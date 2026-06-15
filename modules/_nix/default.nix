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
      {
        installedAt,
        lib,
        nixosVersion,
        system,
        ...
      }:
      {
        _module.args = {
          "pkgs" = lib.mkForce inputs."nixpkgs-${lib.replaceString "." "-" nixosVersion}".legacyPackages.${system};
          "pkgs-26-05" = inputs."nixpkgs-26-05".legacyPackages.${system};
          "pkgs-current" = inputs."nixpkgs-current".legacyPackages.${system};
          "pkgs-unstable" = inputs."nixpkgs-unstable".legacyPackages.${system};
        };

        nix.settings.experimental-features = [
          "nix-command"
          "flakes"
        ];

        nixpkgs.hostPlatform = system;

        # This value determines the NixOS release from which the default
        # settings for stateful data, like file locations and database versions
        # on your system were taken. It‘s perfectly fine and recommended to leave
        # this value at the release version of the first install of this system.
        # Before changing this value read the documentation for this option
        # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
        system.stateVersion = installedAt; # Did you read the comment?
      };
  };
}
