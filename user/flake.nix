{
  outputs = _: {
    args.me = {
      name = "Stijn Ruts";
      username = "stijn";
      email = {
        git = "git@stijnruts.be";
      };
    };

    nixosModules = [
      (
        {
          config,
          lib,
          me,
          ...
        }:
        {
          users.users.${me.username} = {
            isNormalUser = true;
            description = "${me.name}";
            extraGroups = [
              "networkmanager"
              "wheel"
            ];
            hashedPasswordFile = lib.mkIf (me.username != "nixos") config.age.secrets.hashed_password.path;
          };

          age.secrets.hashed_password.file = ../secrets/hashed_password.age;
        }
      )
    ];

    homeModules = [
      (
        { me, ... }:
        {
          home.username = "${me.username}";
          home.homeDirectory = "/home/${me.username}";
        }
      )
    ];
  };
}
