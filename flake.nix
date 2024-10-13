{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.url = "github:nix-community/impermanence";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    {
      self,
      nixpkgs,
      disko,
      impermanence,
      home-manager,
      ...
    }@args:
    {
      nixosConfigurations =
        let
          commonModules = [
            disko.nixosModules.disko
            impermanence.nixosModules.impermanence
            ./impermanence.nix
            ./configuration-system.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.stijn = import ./configuration-home.nix;
              };
            }
          ];
        in
        {
          X201 = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = args;
            modules = commonModules ++ [
              ./disko/X201.nix
              ./hardware/X201.nix
            ];
          };
          T420 = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = args;
            modules = commonModules ++ [
              ./disko/T420.nix
              ./hardware/T420.nix
            ];
          };
        };
    };
}
