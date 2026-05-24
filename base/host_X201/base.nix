{
  hosts.X201 = {
    system = "x86_64-linux";
    options = import ./options.nix;
    disko = import ./disko.nix;
    hardware = import ./hardware.nix;
  };
}
