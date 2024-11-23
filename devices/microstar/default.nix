# https://github.com/nix-community/NixOS-WSL
{ params, ... }:

{
  imports = [
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = params.user;
  wsl.useWindowsDriver = true;
}
