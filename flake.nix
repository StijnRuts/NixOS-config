{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.05";
    };
    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "path:impermanence";
    };
    hosts = {
      url = "path:hosts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    user = {
      url = "path:user";
    };
    secrets = {
      url = "path:secrets";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
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
    apps = {
      url = "path:apps";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs@{ self, ... }:
    {
      nixosConfigurations =
        let
          hostargs = {
            args = {
              # pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux; # implicit
              pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;
              me = inputs.user.settings;
              theme = inputs.theme.settings;
            };

            nixosModules = [
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  backupFileExtension = "hmbackup";
                };
              }
              (
                { pkgs, ... }:
                {
                  environment.systemPackages = with pkgs; [
                    gnumake
                    nh
                    nixfmt-rfc-style
                    nixfmt-tree
                    statix
                  ];
                }
              )
              ./system/nix.nix
              ./system/locale.nix
              ./system/networking.nix
              ./system/audio.nix
              ./system/bluetooth.nix
              ./system/printing.nix
              ./system/energy.nix
            ]
            ++ inputs.impermanence.modules.nixos
            ++ inputs.hosts.modules.nixos
            ++ inputs.user.modules.nixos
            ++ inputs.secrets.modules.nixos
            ++ inputs.KDE.modules.nixos
            ++ inputs.theme.modules.nixos
            ++ inputs.apps.modules.nixos;

            homeModules = [
              ./home/home-manager.nix
              ./home/energy.nix
            ]
            ++ inputs.impermanence.modules.home
            ++ inputs.user.modules.home
            ++ inputs.secrets.modules.home
            ++ inputs.KDE.modules.home
            ++ inputs.theme.modules.home
            ++ inputs.apps.modules.home;
          };
        in
        {
          X201 = inputs.nixpkgs.lib.nixosSystem (inputs.hosts.X201 hostargs);
          T420 = inputs.nixpkgs.lib.nixosSystem (inputs.hosts.T420 hostargs);
          P520 = inputs.nixpkgs.lib.nixosSystem (inputs.hosts.P520 hostargs);
        };
    };
}
