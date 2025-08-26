let
  stijn = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF98vuW/0StmEkZ5jXXvli5sD3fTcdn56M+9xhV1F5u/";
in
{
  "hashed_password.age".publicKeys = [ stijn ];
  "rootCA_cert.age".publicKeys = [ stijn ];
  "rootCA_cert_key.age".publicKeys = [ stijn ];
}
