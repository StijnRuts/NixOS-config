self:
let
  extraArgs = {
    isLaptop = false;
    isServer = true;
  };
in
{
  system = "x86_64-linux";
  specialArgs = self.args // extraArgs;
  modules = [
    ./disko.nix
    ./hardware.nix
  ]
  ++ self.nixosModules
  ++ [
    {
      home-manager = {
        extraSpecialArgs = self.args // extraArgs;
        users.${self.args.me.username}.imports = self.homeModules;
      };
    }
  ];
}
