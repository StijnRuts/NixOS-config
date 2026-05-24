base: {
  homeModules = _: [ ];

  # TODO refactor
  args = _: _: {
    me = import ./stijn/user.nix;
  };

  nixosModules = inputs: [
    (
      {
        config,
        me,
        ...
      }:
      {
        users.users.${me.username} = {
          isNormalUser = true;
          description = "${me.fullname}";
          extraGroups = [
            "networkmanager"
            "wheel"
          ];
          hashedPasswordFile = config.age.secrets.hashed_password.path;
        };

        home-manager = {
          extraSpecialArgs = base.args "x86_64-linux" inputs;
          users.${me.username}.imports = [
            {
              home.username = "${me.username}";
              home.homeDirectory = "/home/${me.username}";

              apps.syncthing.enable = true;
              systray.items = "laptop"; # TODO or desktop
            }
          ]
          ++ (base.homeModules inputs);
        };

        age.secrets.hashed_password.file = ../legacy/secrets/user/hashed_password.age;
      }
    )
  ];
}
