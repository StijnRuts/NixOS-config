{
  inputs = {
    home-manager.url = "github:nix-community/home-manager";
  };
  outputs = inputs: {
    nixosModules.home-manager = {
      imports = [
        inputs.home-manager.nixosModules.home-manager
      ];
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.jdoe = {
          programs.home-manager.enable = true;
          home.stateVersion = "24.05";
        };
      };
    };
  };
}
