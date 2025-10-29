{ me, ... }:
{
  # TODO

  # https://github.com/NixOS/nixpkgs/blob/nixos-25.05/nixos/modules/services/hardware/kmonad.nix#L158
  # https://github.com/NixOS/nixpkgs/blob/nixos-25.05/nixos/modules/services/hardware/kmonad.nix#L239

  services.udev.extraRules = ''
    KERNEL=="uinput", GROUP="input", MODE:="0660"
    KERNEL=="event*", GROUP="input", NAME="input/%k", MODE="660"
  '';
  /*
  sudo tee /etc/udev/rules.d/99-$USER.rules <<EOF
    KERNEL=="uinput", GROUP="$USER", MODE:="0660"
    KERNEL=="event*", GROUP="$USER", NAME="input/%k", MODE="660"
  EOF
  */

  users.users.${me.username} = {
    extraGroups = [ "input" ];
  };
}
