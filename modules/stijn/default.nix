{
  outputs =
    { self, ... }:
    let
      u = {
        username = "stijn";
        fullname = "Stijn Ruts";
        password = "fake";
        nixos = {
          config = { };
        };
        home-manager = {
          enable = true;
          config =
            { pkgs, ... }:
            {
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
      nixosModules.${u.username} = user.nixosModule;
      homeConfigurations.${u.username} = user.homeConfiguration;
    };
}
