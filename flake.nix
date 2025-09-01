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
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?ref=latest";
    };
    KDE = {
      url = "path:KDE";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    theme = {
      url = "path:theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs@{ self, ... }:
    let
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;
      KDEModules = inputs.KDE.modules;
      themeModules = inputs.theme.modules;
    in
    {
      me = {
        name = "Stijn Ruts";
        username = "stijn";
        gitEmail = "git@stijnruts.be";
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
      ]
      ++ KDEModules.nixos
      ++ themeModules.nixos;

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
        ./home/energy.nix
        ./home/wezterm.nix
        ./home/shell.nix
        ./home/git.nix
        inputs.nvf.homeManagerModules.default
        ./home/vim.nix
        ./home/firefox.nix
        ./home/conky.nix
      ]
      ++ KDEModules.home
      ++ themeModules.home;

      nixosConfigurations = {
        X201 =
          let
            myArgs = {
              inherit (self) me;
              inherit pkgs-unstable;
              theme = themeModules.settings;
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
              inherit (self) me;
              inherit pkgs-unstable;
              theme = themeModules.settings;
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
              inherit (self) me;
              inherit pkgs-unstable;
              theme = themeModules.settings;
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
