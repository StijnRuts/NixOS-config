{
  inputs = {
  };
  outputs = inputs: rec {
    settings = {
      name = "Stijn Ruts";
      username = "stijn";
      email = {
        git = "git@stijnruts.be";
      };
    };

    modules = {
      nixos = [
        (
          {
            config,
            pkgs,
            ...
          }:
          {
            users.users.${settings.username} = {
              isNormalUser = true;
              description = "${settings.name}";
              extraGroups = [
                "networkmanager"
                "wheel"
              ];
              hashedPasswordFile = config.age.secrets.hashed_password.path;
            };

            age.secrets.hashed_password.file = ../secrets/hashed_password.age;
          }
        )
      ];

      home = [
        {
          home.username = "${settings.username}";
          home.homeDirectory = "/home/${settings.username}";
        }
      ];
    };
  };
}
