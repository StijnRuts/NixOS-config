{ me, ... }:
{
  age.identityPaths = [ "/persist/home/${me.username}/.ssh/id_ed25519" ];
}
