{
  outputs = _: {
    nixosModules.user-stijn =
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {
        options.user-stijn.enable = lib.mkEnableOption "user-stijn";
        config = lib.mkIf config.user-stijn.enable {
          users.users."stijn" = {
            isNormalUser = true;
            description = "Stijn Ruts";
            password = "fake";
            extraGroups = [ "wheel" ];
          };
          environment.systemPackages = with pkgs; [
            yazi
            helix
            git
            lazygit
          ];
        };
      };
  };
}

