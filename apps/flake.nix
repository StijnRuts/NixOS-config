{
  inputs = {
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };
  outputs = inputs: {
    nixosModules = [
      (
        { pkgs, ... }:
        {
          programs.zsh.enable = true;
          users.defaultUserShell = pkgs.zsh;
        }
      )
      ./gui/office.nix
      ./gui/graphics.nix
      ./gui/beekeeper.nix
      (
        { lib, ... }:
        {
          options.apps.utilities.enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Enable utility apps";
          };
        }
      )
      ./utility/devenv.nix
      ./utility/direnv.nix
      ./utility/process-compose.nix
      ./utility/podman.nix
      ./utility/docker.nix
      ./utility/distrobox.nix
      ./utility/virt-manager.nix
      ./utility/ollama.nix
    ];
    homeModules = [
      ./cli/bash.nix
      ./cli/zsh.nix
      ./cli/nushell.nix
      ./cli/ssh.nix
      ./cli/starship.nix
      ./cli/eza.nix
      ./cli/bat.nix
      ./cli/zoxide.nix
      ./cli/yazi.nix
      ./cli/zellij.nix
      ./cli/atuin.nix
      ./cli/carapace.nix
      ./cli/git.nix
      inputs.nvf.homeManagerModules.default
      ./vim
      ./gui/wezterm.nix
      ./gui/default-browser.nix
      ./gui/firefox.nix
      ./gui/chromium.nix
      inputs.zen-browser.homeModules.beta
      ./gui/zen.nix
      ./gui/conky.nix
      ./misc/syncthing.nix
      ./misc/exercism.nix
    ];
  };
}
