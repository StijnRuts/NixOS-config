let
  extraArgs = {
    isLaptop = false;
    isServer = true;
  };
in
{
  args,
  nixosModules,
  homeModules,
}:
{
  system = "x86_64-linux";
  specialArgs = args // extraArgs;
  modules = [
    ./disko.nix
    ./hardware.nix
  ]
  ++ nixosModules
  ++ [
    {
      home-manager = {
        extraSpecialArgs = args // extraArgs;
        users.${args.me.username}.imports = homeModules;
      };
    }
  ];
}
