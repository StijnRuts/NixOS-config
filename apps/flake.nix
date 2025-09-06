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
  outputs =
    inputs:
    let
      utilitiesOption =
        { lib, ... }:
        {
          options.apps.utilities.enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Enable utility apps";
          };
        };
    in
    {
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
        utilitiesOption
        ./utility/devenv.nix
        ./utility/docker.nix
        ./utility/distrobox.nix
        ./utility/virt-manager.nix
        ./utility/ollama.nix
      ];
      homeModules = [
        ./cli/bash.nix
        ./cli/zsh.nix
        ./cli/ssh.nix
        ./cli/starship.nix
        ./cli/eza.nix
        ./cli/bat.nix
        ./cli/zoxide.nix
        ./cli/yazi.nix
        ./cli/zellij.nix
        ./cli/atuin.nix
        ./cli/git.nix
        inputs.nvf.homeManagerModules.default
        ./cli/vim.nix
        ./gui/wezterm.nix
        ./gui/default-browser.nix
        ./gui/firefox.nix
        ./gui/chromium.nix
        inputs.zen-browser.homeModules.beta
        ./gui/zen.nix
        ./gui/conky.nix
        utilitiesOption
        ./utility/direnv.nix
        ./utility/process-compose.nix
      ];
    };
}
