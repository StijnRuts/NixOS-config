let
  stijn = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF98vuW/0StmEkZ5jXXvli5sD3fTcdn56M+9xhV1F5u/";
in
{
  # \cat somefile | agenix -e somefile.age
  "user/hashed_password.age".publicKeys = [ stijn ];
  "rootCA/cert.age".publicKeys = [ stijn ];
  "rootCA/cert_key.age".publicKeys = [ stijn ];
  "atuin/cert.age".publicKeys = [ stijn ];
  "atuin/cert_key.age".publicKeys = [ stijn ];
  "atuin/session.age".publicKeys = [ stijn ];
  "atuin/key.age".publicKeys = [ stijn ];
  "nextcloud/admin_pass.age".publicKeys = [ stijn ];
  "nextcloud/cert.age".publicKeys = [ stijn ];
  "nextcloud/cert_key.age".publicKeys = [ stijn ];
  "tarsnap/nextcloud.age".publicKeys = [ stijn ];
}
