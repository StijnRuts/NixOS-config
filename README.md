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
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub

git clone git@github.com:StijnRuts/NixOS-config.git ~/NixOS
git clone git@github.com:StijnRuts/Templates.git ~/Templates
```
