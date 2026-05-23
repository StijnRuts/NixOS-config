{
  inputs = {
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };
  nixosModules = _: [
    ./desktop.nix
    ./sddm.nix
  ];
  homeModules = inputs: [
    inputs.plasma-manager.homeModules.plasma-manager
    ./plasma.nix
    ./dolphin.nix
    ./konsole.nix
  ];
}
