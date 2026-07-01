{
  outputs =
    { self, ... }:
    let
      u = {
        user = {
          username = "stijn";
          fullname = "Stijn Ruts";
          password = "fake";
        };
        nixos = {
          config = {
            custom = {
              home-manager.enable = true;
              niri.enable = true;
              belgium.enable = true;
            };
          };
        };
        home-manager = {
          enable = true;
          config =
            { pkgs, ... }:
            {
              custom = {
                niri.enable = true;
                foot.enable = true;
                ssh.enable = true;
                git.enable = true;
                git.email = "git@stijnruts.be";
              };
              # TODO move
              home.packages = with pkgs; [
                yazi
                helix
                qutebrowser
              ];
            };
        };
      };
      user = self.lib.mkUser u;
    in
    {
      nixosModules.${u.user.username} = user.nixosModule;
      homeConfigurations.${u.user.username} = user.homeConfiguration;
    };
}
