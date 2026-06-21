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
              belgium.enable = true;
            };
          };
        };
        home-manager = {
          enable = true;
          config =
            { pkgs, ... }:
            {
              custom.foot.enable = true;
              # TODO move
              home.packages = with pkgs; [
                yazi
                helix
                git
                lazygit
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
