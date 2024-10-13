# Installing

```bash
git clone https://github.com/StijnRuts/NixOS-config.git
cd NixOS-config

sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode disko ./disko/???.nix

sudo nixos-install --no-root-password --flake .#???
```

## New device

```bash
sudo nixos-generate-config --no-filesystems --root /mnt
vim /mnt/etc/nixos/hardware-configuration.nix
```

## After install

```bash
git clone https://github.com/StijnRuts/NixOS-config.git ~/NixOS
cd ~/NixOS
git remote set-url origin git@github.com:StijnRuts/NixOS-config.git
```
