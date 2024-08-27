# nixos
My conf files for a reproducible NixOS linux environment

# Quickstart

```bash
ssh-keygen -t rsa
# setup in github

git config --global user.email "forsureitsme@gmail.com"
git config --global user.name "Pedro Cardoso da Silva"

git clone git@github.com:forsureitsme/nixos.git
sudo rm /etc/nixos/configuration.nix
sudo ln -s ~/nixos/configuration.nix /etc/nixos/configuration.nix
sudo nixos-rebuild switch
```
