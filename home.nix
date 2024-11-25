{ pkgs, params, config, ... }:
let
  # Until PR 313760 on nixpkgs is merged
  bunBaseline = pkgs.bun.overrideAttrs rec {
    passthru.sources."x86_64-linux" = pkgs.fetchurl {
      url = "https://github.com/oven-sh/bun/releases/download/bun-v1.1.27/bun-linux-x64-baseline.zip";
      hash = "sha256-FwkVP5lb2V9E8YGPkTAqVMsZmaZXMq8x5AR+99cuIX0=";
    };
    src = passthru.sources."x86_64-linux";
  };
in
with config; {
  imports = let deviceModule = "${params.deviceConfigPath}/home.nix"; in (
    if builtins.pathExists deviceModule then [ deviceModule ] else []
  );

  programs.home-manager.enable = true;
  home = {
    username = params.user;
    homeDirectory = "/home/${home.username}";
    stateVersion = "24.05";
    packages = with pkgs; [
      lazygit
      nodejs
    ] ++ [
      bunBaseline
    ];
  };

  # Symlink configs
  systemd.user.tmpfiles.rules = [
    "L+ ${home.homeDirectory}/.config/nvim/ - - - - ${home.homeDirectory}/nixos/dotfiles/.config/nvim/"
  ];

  programs = {
    git = {
      enable = true;
      userName = "Pedro Cardoso da Silva (@forsureitsme)";
      userEmail = "forsureitsme@gmail.com";
    };

    neovim = {
      enable = true;

      extraPackages = with pkgs; [
        zig
        ripgrep
        fd
        unzip
        wget
        python3
        cargo
      ];
    };

    zsh = {
      enable = true;
      enableVteIntegration = true;

      oh-my-zsh = {
        enable = true;
        theme = "agnoster";
        plugins = [
          "git"
          "sudo"
        ];
      };
    };
  };
}
