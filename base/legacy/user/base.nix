{
  args = _: _: {
    me = {
      name = "Stijn Ruts";
      username = "stijn";
      email = {
        git = "git@stijnruts.be";
      };
    };
  };

  nixosModules = _: [
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

        age.secrets.hashed_password.file = ../secrets/user/hashed_password.age;
      }
    )
  ];

  homeModules = _: [
    (
      { me, ... }:
      {
        home.username = "${me.username}";
        home.homeDirectory = "/home/${me.username}";
      }
    )
  ];
}
