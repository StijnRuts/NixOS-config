{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs: {
    packages.x86_64-linux = {
      default =
        let
          pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
          pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;
          themeModule = import ../../theme/flake.nix;
          themeConfig = themeModule.outputs {
            inherit (inputs) nixpkgs;
            catppuccin = null;
          };
          vimModule = import ../../apps/cli/vim.nix;
          vimconfig = vimModule {
            inherit pkgs-unstable;
            theme = themeConfig.args.theme;
          };
        in
        (inputs.nvf.lib.neovimConfiguration {
          inherit pkgs;
          modules = [
            {
              config.vim = vimconfig.programs.nvf.settings.vim;
            }
          ];
        }).neovim;
    };
  };
}
