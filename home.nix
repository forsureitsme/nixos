{ config, pkgs, params, lib, ... }:
let
  # Until PR 313760 on nixpkgs is merged
  bunBaseline = pkgs.bun.overrideAttrs rec {
    passthru.sources."x86_64-linux" = pkgs.fetchurl {
      url = "https://github.com/oven-sh/bun/releases/download/bun-v1.1.27/bun-linux-x64-baseline.zip";
      hash = "sha256-FwkVP5lb2V9E8YGPkTAqVMsZmaZXMq8x5AR+99cuIX0=";
    };
    src = passthru.sources."x86_64-linux";
  };
  vimPluginFromGithub = ref: repo: pkgs.vimUtils.buildVimPlugin {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
  };
in
rec {
  programs.home-manager.enable = true;
  home = rec {
    username = params.user;
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";
    packages = with pkgs; [
      brave
      nautilus
      wl-clipboard

      gnome-terminal
      lazygit

      lunarvim
      # gnome-tweaks

      (nerdfonts.override { fonts = ["Ubuntu" "UbuntuMono"]; })
    ] ++ [
      bunBaseline
    ];
  };

  fonts.fontconfig = {
    enable = true;
  };

  systemd.user.tmpfiles.rules = [
    "L+ ${home.homeDirectory}/.config/lvim/ - - - - ${home.homeDirectory}/nixos/dotfiles/.config/lvim/"
  ];

  dconf.settings = {
    "org/gnome/desktop/background" = {
      picture-uri-dark = "file://${(pkgs.fetchurl {
        url = "https://pm1.aminoapps.com/6612/3a75e0d96b11a5083c1b4a87fc795f04f7b036b7_hq.jpg";
        hash = "sha256-s1+li8Hyp8zfO2GArgCyYgkwV96LfmH7Tzn0Y/iIMFM=";
      })}";
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      show-battery-percentage = true;
    
      font-name = "Ubuntu Nerd Font 11";
      monospace-font-name = "UbuntuMono Nerd Font 10";
      document-font-name = "Ubuntu Nerd Font 10";
    };

    "org/gnome/desktop/search-providers" = {
      disable-external = true;
    };

    "org/freedesktop/tracker/miner/files" = {
      index-single-directories = [ ];
      index-recursive-directories = [ ];
    };

    "org/gnome/desktop/privacy" = {
      remember-recent-files = false;
      remove-old-trash-files = true;
      remove-old-temp-files = true;
      old-files-age = 0;
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = true;
    };

    "org.gnome.settings-daemon.plugins.power" = {
      idle-dim = true;
      power-saver-profile-on-low-battery = false;
      power-button-action = "nothing";
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-battery-type = "nothing";
    };

    "org/gnome/shell/extensions/blur-my-shell" = {
      hacks-level = 0;
    };
  };

  programs = {
    gnome-shell = {
      enable = true;

      extensions = with pkgs.gnomeExtensions; [
        { package = blur-my-shell; }
        { package = forge; }
      ];
    };


    git = {
      enable = true;
      userName = "Pedro Cardoso da Silva (@forsureitsme)";
      userEmail = "forsureitsme@gmail.com";
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
