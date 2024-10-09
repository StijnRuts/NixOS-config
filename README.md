# Installing

```bash
sudo -i

curl -o disko.nix https://raw.githubusercontent.com/StijnRuts/NixOS-config/refs/heads/main/disko/???.nix

nix --experimental-features "nix-command flakes" \
  run github:nix-community/disko -- --mode disko ./disko.nix

# For new devices
nixos-generate-config --force --root /mnt
vim /mnt/etc/nixos/hardware-configuration.nix

mkdir -p /mnt/home/stijn/NixOS
git clone https://github.com/StijnRuts/NixOS-config.git /mnt/home/stijn/NixOS
cd /mnt/home/stijn/NixOS
git remote set-url origin git@github.com:StijnRuts/NixOS-config.git

nixos-install --no-root-passwd --flake .#???
```
