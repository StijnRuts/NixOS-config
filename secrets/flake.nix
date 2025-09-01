{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.05";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.darwin.follows = "";
    };
  };
  outputs = inputs: {
    modules = {
      nixos = [
        inputs.agenix.nixosModules.default
        { environment.systemPackages = [ inputs.agenix.packages.x86_64-linux.default ]; }
        ./age_identity.nix
      ];
      home = [
        inputs.agenix.homeManagerModules.default
        ./age_identity.nix
      ];
    };
  };
}
