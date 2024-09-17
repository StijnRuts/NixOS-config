# Installing

```bash
sudo -i

nix --experimental-features "nix-command flakes" \
  run github:nix-community/disko -- --mode disko ./disko/???.nix

nixos-generate-config --force --root /mnt

vim /mnt/etc/nixos/hardware-configuration.nix

rm -rf /mnt/etc/nixos/*
cp -r * /mnt/etc/nixos

nixos-install --no-root-passwd
reboot
```
