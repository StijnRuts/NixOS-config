{
  inputs = {
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };
  outputs = inputs: {
    nixosModules = [
      ./desktop.nix
      ./sddm.nix
    ];
    homeModules = [
      inputs.plasma-manager.homeModules.plasma-manager
      ./plasma.nix
      ./dolphin.nix
      ./konsole.nix
      ./automaximize.nix
    ];
  };
}
