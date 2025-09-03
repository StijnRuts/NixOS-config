{
  inputs = {
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?ref=latest";
    };
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
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
      ./gui/zen.nix
      inputs.nix-flatpak.nixosModules.nix-flatpak
      ./utility/flatpak.nix
      ./utility/devenv.nix
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
      ./gui/firefox.nix
      ./gui/chromium.nix
      ./gui/conky.nix
      ./utility/direnv.nix
      ./utility/process-compose.nix
    ];
  };
}
