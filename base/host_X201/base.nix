{
  hosts.X201 = {
    system = "x86_64-linux";
    options = import ./options.nix;
    hardware = import ./hardware.nix;
  };
}
