{
  config,
  pkgs,
  me,
  ...
}:
{
  users.users.${me.username} = {
    isNormalUser = true;
    description = "${me.name}";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    hashedPasswordFile = config.age.secrets.hashed_password.path;
  };

  age.secrets.hashed_password.file = ../secrets/hashed_password.age;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
}
