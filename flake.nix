{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.05";
    };
    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.darwin.follows = "";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    catppuccin = {
      url = "github:catppuccin/nix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      disko,
      impermanence,
      agenix,
      home-manager,
      plasma-manager,
      catppuccin,
      ...
    }@args:
    {
      nixosConfigurations =
        let
          systemtype = "x86_64-linux";
          me = {
            name = "Stijn Ruts";
            username = "stijn";
            gitEmail = "git@stijnruts.be";
          };
          theme = {
            flavor = "mocha";
            Flavor = "Mocha";
            accent = "yellow";
            Accent = "Yellow";
            font = "Ubuntu";
            monofont = "UbuntuMono Nerd Font";
            fontPkg = nixpkgs.legacyPackages.${systemtype}.ubuntu_font_family;
            monofontPkg = nixpkgs.legacyPackages.${systemtype}.nerd-fonts.ubuntu-mono;
            backgroundColor = "30,30,40";
          };
          pkgs-unstable = nixpkgs-unstable.legacyPackages.${systemtype};
          commonModules = [
            disko.nixosModules.disko
            impermanence.nixosModules.impermanence
            ./system/impermanence.nix
            agenix.nixosModules.default
            { environment.systemPackages = [ agenix.packages.${systemtype}.default ]; }
            ./secrets/age_identity.nix
            home-manager.nixosModules.home-manager
            homeManagerConfig
            catppuccin.nixosModules.catppuccin
            ./system/nix.nix
            ./system/user.nix
            ./system/locale.nix
            ./system/desktop.nix
            ./system/theme.nix
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
            agenix.homeManagerModules.default
            ./secrets/age_identity.nix
            plasma-manager.homeManagerModules.plasma-manager
            catppuccin.homeModules.catppuccin
            ./home/home-manager.nix
            ./home/theme.nix
            ./home/kde.nix
            ./home/energy.nix
            ./home/shell.nix
            ./home/wezterm.nix
            ./home/git.nix
            ./home/vim.nix
            ./home/firefox.nix
            ./home/conky.nix
          ];
          serverModules = [
          ];
        in
        {
          X201 =
            let
              myArgs = args // {
                inherit me;
                inherit theme;
                inherit pkgs-unstable;
                isLaptop = true;
                isServer = false;
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
                inherit theme;
                inherit pkgs-unstable;
                isLaptop = true;
                isServer = false;
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
                inherit theme;
                inherit pkgs-unstable;
                isLaptop = false;
                isServer = true;
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
              ++ commonModules
              ++ serverModules;
            };
        };
    };
}
