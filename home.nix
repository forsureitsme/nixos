{ config, pkgs, params, ... }: {
  programs.home-manager.enable = true;
  home = rec {
    username = params.user;
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";
    packages = with pkgs; [
      brave
      vscode.fhs
      # gnome-tweaks
      nautilus
      deno
      lazygit

      # neovim plugin dependencies
      wl-clipboard
    ];
  };

  dconf.settings = {
    "org/gnome/desktop/background" = {
      picture-uri-dark = "file://${(pkgs.fetchurl {
        url = "https://static1.thegamerimages.com/wordpress/wp-content/uploads/2020/11/Dusa.jpg";
        hash = "sha256-zXTwyuo0WL4FG1ovclvbEX2cP3oxoJxvk+HO52JJNIY=";
      })}";
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      show-battery-percentage = true;
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

    wezterm = {
      enable = true;
      extraConfig = ''
       return {
         front_end = "WebGpu"
       }
      '';
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
          "vscode"
        ];
      };
    };

    neovim = {
      enable = true;
      defaultEditor = true;
    };

  };
}
