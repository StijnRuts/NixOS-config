{
  inputs = {
    config = {
      url = "path:../..";
    };
    nixpkgs.follows = "config/nixpkgs";
    nvf.follows = "config/nvf";
  };
  outputs = inputs: {
    packages.x86_64-linux = {
      default =
        let
          vimConfig = (import ../../apps/cli/vim.nix) {
            inherit (inputs.config.args) pkgs-unstable theme;
          };
        in
        (inputs.nvf.lib.neovimConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            {
              config.vim = vimConfig.programs.nvf.settings.vim;
            }
          ];
        }).neovim;
    };
  };
}
