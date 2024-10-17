{
  config,
  pkgs,
  home-manager,
  ...
}:
{
  imports = [
    ./home/home-manager.nix
    ./home/shell.nix
    ./home/git.nix
    ./home/vim.nix
    ./home/theme.nix
  ];
}
