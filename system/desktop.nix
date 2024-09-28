{ config, pkgs, ... }:
let
  sddmYellow = import ./theme/sddm-yellow.nix { inherit pkgs; };
in {
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    theme = "yellow";
  };

  environment.plasma6.excludePackages = [
    # pkgs.kdePackages.konsole # replaced with wezterm, but kept for Dolphin integration
    pkgs.kdePackages.elisa # replaced with vlc
    # pkgs.kdePackages.kate # replaced with neovim
  ];

  environment.systemPackages = with pkgs; [
    sddmYellow
    wezterm
    vlc
    neovim
  ];

  services.printing.enable = true;
  services.printing.drivers = [
    pkgs.gutenprint
    pkgs.gutenprintBin
    pkgs.brlaser
  ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # NixOS allows either a lightweight build (default) or full build of PulseAudio to be installed.
  # Only the full build has Bluetooth support, so it must be selected here.
  hardware.pulseaudio.enable = false;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.firefox.enable = true;
}
