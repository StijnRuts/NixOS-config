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

  "syncthing/P520_cert.age".publicKeys = [ stijn ];
  "syncthing/P520_key.age".publicKeys = [ stijn ];
  "syncthing/T420_cert.age".publicKeys = [ stijn ];
  "syncthing/T420_key.age".publicKeys = [ stijn ];
  "syncthing/X201_cert.age".publicKeys = [ stijn ];
  "syncthing/X201_key.age".publicKeys = [ stijn ];

  "tarsnap/homedirs.age".publicKeys = [ stijn ];
}
