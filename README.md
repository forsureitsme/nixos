# nixos

My modular flake for reproducible NixOS linux environments

## WSL

After installing this flake in a new WSL environment, run the following commands to update the shell startup user (consider `NixOS` as the environment name):

```pwsh
wsl -t NixOS.
wsl -d NixOS --user root exit
wsl -t NixOS
```
