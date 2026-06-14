{
  outputs =
    { self, ... }:
    {
      nixosModules.stijn =
        {
          config,
          lib,
          pkgs,
          ...
        }:
        {
          imports = [
            self.nixosModules.users
          ];
          options.custom.stijn.enable = lib.mkEnableOption "stijn";
          config = lib.mkIf config.custom.stijn.enable {
            custom.users.stijn = {
              fullname = "Stijn Ruts";
              password = "fake";
              # hashedPasswordFile = config.age.secrets.hashed_password.path; # TODO
            };
            # TODO remove
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
