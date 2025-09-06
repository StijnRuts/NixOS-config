self:
let
  myOptions = import ./options.nix;
in
{
  system = "x86_64-linux";
  specialArgs = self.args;
  modules = [
    (
      { modulesPath, ... }:
      {
        imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];
      }
    )
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
