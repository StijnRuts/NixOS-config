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
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?ref=latest";
    };
  };
  outputs =
    inputs@{ self, ... }:
    {
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
        fontPkg = inputs.nixpkgs.legacyPackages.x86_64-linux.ubuntu_font_family;
        monofontPkg = inputs.nixpkgs.legacyPackages.x86_64-linux.nerd-fonts.ubuntu-mono;
        backgroundColor = "30,30,40";
      };

      nixosModules = [
        inputs.disko.nixosModules.disko
        inputs.impermanence.nixosModules.impermanence
        ./system/impermanence.nix
        inputs.agenix.nixosModules.default
        { environment.systemPackages = [ inputs.agenix.packages.x86_64-linux.default ]; }
        ./secrets/age_identity.nix
        inputs.home-manager.nixosModules.home-manager
        self.homeManagerConfig
        ./system/nix.nix
        ./system/user.nix
        ./system/locale.nix
        ./system/desktop.nix
        inputs.catppuccin.nixosModules.catppuccin
        ./system/desktop-theme.nix
        ./system/networking.nix
        ./system/audio.nix
        ./system/bluetooth.nix
        ./system/printing.nix
        ./system/energy.nix
        ./system/apps.nix
        inputs.nix-flatpak.nixosModules.nix-flatpak
        ./system/flatpak.nix
        ./system/distrobox.nix
        ./system/virt-manager.nix
        ./system/ollama.nix
      ];

      homeManagerConfig = {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "hmbackup";
          users.${self.me.username}.imports = self.homeModules;
        };
      };

      homeModules = [
        inputs.impermanence.homeManagerModules.impermanence
        inputs.agenix.homeManagerModules.default
        ./secrets/age_identity.nix
        ./home/home-manager.nix
        inputs.catppuccin.homeModules.catppuccin
        ./home/desktop-theme.nix
        ./home/energy.nix
        inputs.plasma-manager.homeManagerModules.plasma-manager
        ./home/kde.nix
        ./home/dolphin.nix
        ./home/konsole.nix
        ./home/wezterm.nix
        ./home/shell.nix
        ./home/git.nix
        inputs.nvf.homeManagerModules.default
        ./home/vim.nix
        ./home/firefox.nix
        ./home/conky.nix
      ];

      pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;

      nixosConfigurations = {
        X201 =
          let
            myArgs = {
              inherit (self) me theme pkgs-unstable;
              isLaptop = true;
              isServer = false;
            };
          in
          inputs.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = myArgs;
            modules = [
              { home-manager.extraSpecialArgs = myArgs; }
              ./disko/X201.nix
              ./hardware/X201.nix
            ]
            ++ self.nixosModules;
          };
        T420 =
          let
            myArgs = {
              inherit (self) me theme pkgs-unstable;
              isLaptop = true;
              isServer = false;
            };
          in
          inputs.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = myArgs;
            modules = [
              { home-manager.extraSpecialArgs = myArgs; }
              ./disko/T420.nix
              ./hardware/T420.nix
            ]
            ++ self.nixosModules;
          };
        P520 =
          let
            myArgs = {
              inherit (self) me theme pkgs-unstable;
              isLaptop = false;
              isServer = true;
            };
          in
          inputs.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = myArgs;
            modules = [
              { home-manager.extraSpecialArgs = myArgs; }
              ./disko/P520.nix
              ./hardware/P520.nix
            ]
            ++ self.nixosModules;
          };
      };
    };
}
