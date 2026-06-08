self:
let
  myOptions = import ./options.nix;
in
{
  system = "x86_64-linux";
  specialArgs = self.args;
  modules = [
    ./disko.nix
    ./hardware.nix
    myOptions.system
  ]
  ++ self.nixosModules
  ++ [
    {
      home-manager = {
        extraSpecialArgs = self.args;
        users.${self.args.me.username}.imports = [ myOptions.home ] ++ self.homeModules;
      };
    }
  ];
}
