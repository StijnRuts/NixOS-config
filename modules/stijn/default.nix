{
  outputs =
    { self, ... }:
    let username = "stijn"; in
    {
      nixosModules.${username} =
        {
          config,
          lib,
          ...
        }:
        {
          imports = [
            self.nixosModules.home-manager
            self.nixosModules.users
          ];
          options.custom.${username}.enable = lib.mkEnableOption username;
          config = lib.mkIf config.custom.${username}.enable {
            custom.users.${username} = {
              fullname = "Stijn Ruts";
              password = "fake";
              # hashedPasswordFile = config.age.secrets.hashed_password.path; # TODO
            };
            home-manager.users.${username} = self.homeConfigurations.${username};
          };
        };
      homeConfigurations.${username} = {pkgs,...}: {
        imports = [
          self.homeModules.home-manager
        ];
        custom.home-manager.user = username;
        # TODO move
        home.packages = with pkgs; [
          yazi
          helix
          git
          lazygit
        ];
      };
    };
}
