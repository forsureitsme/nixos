# nixos
My conf files for a reproducible NixOS linux environment

```bash
sudo nixos-rebuild switch --impure --flake github:forsureitsme/nixos#piter-chromebook
```

<!-- # Quickstart
Reuse after migrating todo-wsl
Setup configuration
```bash
ssh-keygen -t rsa
# setup in github

git config --global user.email "forsureitsme@gmail.com"
git config --global user.name "Pedro Cardoso da Silva"

git clone git@github.com:forsureitsme/nixos.git
sudo rm /etc/nixos/configuration.nix
sudo ln -s ~/nixos/configuration.nix /etc/nixos/configuration.nix
sudo nixos-rebuild boot
```

Procedure to change username
```cmd
wsl -t NixOS
wsl -d NixOS --user root exit
wsl -t NixOS
```

Procedure after changing username
```bash
cp /home/nixos/nixos ~/nixos
cp /home/nixos/.ssh ~/.ssh

sudo nixos-rebuild switch
``` -->
