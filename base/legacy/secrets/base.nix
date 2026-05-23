{
  inputs = {
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        darwin.follows = "";
      };
    };
  };
  nixosModules = inputs: [
    inputs.agenix.nixosModules.default
    { environment.systemPackages = [ inputs.agenix.packages.x86_64-linux.default ]; }
    ./age_identity.nix
  ];
  homeModules = inputs: [
    inputs.agenix.homeManagerModules.default
    ./age_identity.nix
  ];
}
