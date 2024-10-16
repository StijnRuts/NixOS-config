{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.url = "github:nix-community/impermanence";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.url = "github:nix-community/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";
  };
  outputs =
    {
      self,
      nixpkgs,
      disko,
      impermanence,
      home-manager,
      plasma-manager,
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
                backupFileExtension = "backup";
                sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
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
