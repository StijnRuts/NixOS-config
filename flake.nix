{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.url = "github:nix-community/impermanence";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.url = "github:nix-community/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";
    catppuccin.url = "github:catppuccin/nix/release-25.05";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      disko,
      impermanence,
      home-manager,
      plasma-manager,
      catppuccin,
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
          systemtype = "x86_64-linux";
          pkgs-unstable = nixpkgs-unstable.legacyPackages.${systemtype};
          commonModules = [
            disko.nixosModules.disko
            impermanence.nixosModules.impermanence
            home-manager.nixosModules.home-manager
            homeManagerConfig
            catppuccin.nixosModules.catppuccin
            ./system/impermanence.nix
            ./system/nix.nix
            ./system/user.nix
            ./system/locale.nix
            ./system/desktop.nix
            ./system/networking.nix
            ./system/audio.nix
            ./system/bluetooth.nix
            ./system/printing.nix
            ./system/energy.nix
            ./system/apps.nix
            ./system/distrobox.nix
            ./system/ollama.nix
          ];
          homeManagerConfig = {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "hmbackup";
              users.${me.username}.imports = homeModules;
            };
          };
          homeModules = [
            impermanence.homeManagerModules.impermanence
            plasma-manager.homeManagerModules.plasma-manager
            catppuccin.homeModules.catppuccin
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
          X201 =
            let
              myArgs = args // {
                inherit me;
                inherit pkgs-unstable;
                isLaptop = true;
              };
            in
            nixpkgs.lib.nixosSystem {
              system = systemtype;
              specialArgs = myArgs;
              modules = [
                { home-manager.extraSpecialArgs = myArgs; }
                ./disko/X201.nix
                ./hardware/X201.nix
              ]
              ++ commonModules;
            };
          T420 =
            let
              myArgs = args // {
                inherit me;
                inherit pkgs-unstable;
                isLaptop = true;
              };
            in
            nixpkgs.lib.nixosSystem {
              system = systemtype;
              specialArgs = myArgs;
              modules = [
                { home-manager.extraSpecialArgs = myArgs; }
                ./disko/T420.nix
                ./hardware/T420.nix
              ]
              ++ commonModules;
            };
          P520 =
            let
              myArgs = args // {
                inherit me;
                inherit pkgs-unstable;
                isLaptop = false;
              };
            in
            nixpkgs.lib.nixosSystem {
              system = systemtype;
              specialArgs = myArgs;
              modules = [
                { home-manager.extraSpecialArgs = myArgs; }
                ./disko/P520.nix
                ./hardware/P520.nix
              ]
              ++ commonModules;
            };
        };
    };
}
