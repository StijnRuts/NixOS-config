{
  inputs = {
    "nixpkgs-26-05" = {
      url = "github:NixOS/nixpkgs/nixos-26.05";
    };
    "nixpkgs-current" = {
      url = "github:NixOS/nixpkgs/nixos-26.05";
    };
    "nixpkgs-unstable" = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
  };
  outputs = inputs: {
    nixosModules.nix =
      { host, ... }:
      {
        nixpkgs.hostPlatform = host.system;

        _module.args = {
          "pkgs-26-05" = inputs."nixpkgs-26-05".legacyPackages.${host.system};
          "pkgs-current" = inputs."nixpkgs-current".legacyPackages.${host.system};
          "pkgs-unstable" = inputs."nixpkgs-unstable".legacyPackages.${host.system};
        };

        system.stateVersion = host.installedAt;

        nix.settings.experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
  };
}
