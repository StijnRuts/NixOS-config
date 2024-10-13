{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    {
      self,
      nixpkgs,
      disko,
      ...
    }@args:
    {
      nixosConfigurations = {
        X201 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = args;
          modules = [
            disko.nixosModules.disko
            ./disko/X201.nix
            ./hardware/X201.nix
            ./configuration.nix
          ];
        };
        T420 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = args;
          modules = [
            disko.nixosModules.disko
            ./disko/T420.nix
            ./hardware/T420.nix
            ./configuration.nix
          ];
        };
      };
    };
}
