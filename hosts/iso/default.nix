self:
let
  myOptions = import ./options.nix;
  customArgs = self.args // {
    me = {
      name = "NixOS";
      username = "nixos";
      email = {
        git = "invalid@example.com";
      };
    };
  };
in
{
  system = "x86_64-linux";
  specialArgs = customArgs;
  modules = [
    (
      { modulesPath, ... }:
      {
        imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-graphical-calamares-plasma6.nix") ];
      }
    )
    myOptions.system
  ]
  ++ self.nixosModules
  ++ [
    {
      home-manager = {
        extraSpecialArgs = customArgs;
        users.${customArgs.me.username}.imports = [ myOptions.home ] ++ self.homeModules;
      };
    }
  ];
}
