# nixos
My conf files for a reproducible NixOS linux environment

# Quickstart
After setting up github credentials:

```bash
git clone git@github.com:forsureitsme/nixos.git
sudo rm /etc/nixos/configuration.nix
sudo ln -s ~/nixos/configuration.nix /etc/nixos/configuration.nix
sudo nixos-rebuild switch
```
