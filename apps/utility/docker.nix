{ pkgs, ... }:
{
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  environment.systemPackages = [
    pkgs.lazydocker
  ];

  persist.home = {
    directories = [
      ".local/share/docker"
    ];
  };
  persist.system = {
    directories = [
      "/var/lib/docker"
    ];
  };
}
