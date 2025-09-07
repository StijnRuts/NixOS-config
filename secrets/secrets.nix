let
  stijn = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF98vuW/0StmEkZ5jXXvli5sD3fTcdn56M+9xhV1F5u/";
in
{
  # \cat somefile | agenix -e somefile.age
  "hashed_password.age".publicKeys = [ stijn ];
  "rootCA_cert.age".publicKeys = [ stijn ];
  "rootCA_cert_key.age".publicKeys = [ stijn ];
  "atuin_cert.age".publicKeys = [ stijn ];
  "atuin_cert_key.age".publicKeys = [ stijn ];
  "atuin_session.age".publicKeys = [ stijn ];
  "atuin_key.age".publicKeys = [ stijn ];
  "nextcloud_admin_pass.age".publicKeys = [ stijn ];
  "nextcloud_cert.age".publicKeys = [ stijn ];
  "nextcloud_cert_key.age".publicKeys = [ stijn ];
}
