{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.url = "github:nix-community/impermanence";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.url = "github:nix-community/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";
  };
  outputs =
    {
      self,
      nixpkgs,
      disko,
      impermanence,
      home-manager,
      plasma-manager,
      ...
    }@args:
    {
      nixosConfigurations =
        let
          me = {
            name = "Stijn Ruts";
            username = "stijn";
            gitEmail = "git@stijnruts.be";
          };
          specialArgs = args // {
            inherit me;
          };
          commonModules = [
            disko.nixosModules.disko
            impermanence.nixosModules.impermanence
            home-manager.nixosModules.home-manager
            homeManagerConfig
            ./system/impermanence.nix
            ./system/nix.nix
            ./system/user.nix
            ./system/locale.nix
            ./system/desktop.nix
            ./system/networking.nix
            ./system/audio.nix
            ./system/bluetooth.nix
            ./system/printing.nix
            ./system/apps.nix
            ./system/devenv.nix
            ./system/distrobox.nix
            ./system/ollama.nix
          ];
          laptopModules = [
            ./system/energy.nix
          ];
          homeManagerConfig = {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "hmbackup";
              sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
              extraSpecialArgs = specialArgs;
              users.${me.username}.imports = homeModules;
            };
          };
          homeModules = [
            impermanence.homeManagerModules.impermanence
            ./home/home-manager.nix
            ./home/shell.nix
            ./home/wezterm.nix
            ./home/git.nix
            ./home/vim.nix
            ./home/theme.nix
            ./home/kde.nix
            ./home/firefox.nix
            ./home/conky.nix
          ];
        in
        {
          X201 = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = specialArgs;
            modules = [
              ./disko/X201.nix
              ./hardware/X201.nix
            ]
            ++ commonModules
            ++ laptopModules;
          };
          T420 = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = specialArgs;
            modules = [
              ./disko/T420.nix
              ./hardware/T420.nix
            ]
            ++ commonModules
            ++ laptopModules;
          };
        };
    };
}
