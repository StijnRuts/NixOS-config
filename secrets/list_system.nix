{ me, ... }:
{
  age.identityPaths = [ "/persist/home/${me.username}/.ssh/id_ed25519" ];

  age.secrets = {
    hashed_password.file = ./hashed_password.age;

    rootCA_cert = {
      file = ./rootCA_cert.age;
      path = "/home/${me.username}/.local/share/mkcert/rootCA.pem";
      owner = me.username;
      group = "users";
    };
    rootCA_cert_key = {
      file = ./rootCA_cert_key.age;
      path = "/home/${me.username}/.local/share/mkcert/rootCA-key.pem";
      owner = me.username;
      group = "users";
    };

    atuin_cert = {
      file = ./atuin_cert.age;
      owner = "caddy";
      group = "caddy";
    };
    atuin_cert_key = {
      file = ./atuin_cert_key.age;
      owner = "caddy";
      group = "caddy";
    };
  };
}
