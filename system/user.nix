{ config, pkgs, ... }:
{
  users.users.stijn = {
    isNormalUser = true;
    description = "Stijn Ruts";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    hashedPassword = "$y$j9T$bpwA64h33y5qzHF9DWHMA1$5EzaKxODfsxX1HjWRtPOA5Hap5.Zb2JS4pA5UCDCPjA";
  };
}
