{ me, ... }:
{
  age.identityPaths = [ "/persist/home/${me.username}/.ssh/id_ed25519" ];
  age.secrets.hashed_password.file = ./hashed_password.age;
}
