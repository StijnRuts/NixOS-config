{ me, ... }:
{
  age.identityPaths = [ "/persist/home/${me.username}/.ssh/id_ed25519" ];

  age.secrets = {
    # atuin_session.file = ./atuin_session.age;
    # atuin_key.file = ./atuin_key.age;
  };
}
