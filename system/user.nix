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
    hashedPassword = "$y$j9T$bpwA64h33y5qzHF9DWHMA1$5EzaKxODfsxX1HjWRtPOA5Hap5.Zb2JS4pA5UCDCPjA";
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
}
