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
          pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
          vimConfig = (import ../../apps/cli/vim.nix) {
            inherit pkgs;
            inherit (inputs.config.args) pkgs-unstable theme;
          };
        in
        (inputs.nvf.lib.neovimConfiguration {
          inherit pkgs;
          modules = [
            {
              config.vim = vimConfig.programs.nvf.settings.vim;
            }
          ];
        }).neovim;
    };
  };
}
