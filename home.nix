{ config, pkgs, params, ... }: {
  # TODO: Install Synthwave X Fluormachine theme and patch vscode with it's css

  programs.home-manager.enable = true;
  home = rec {
    username = params.user;
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";
    packages = with pkgs; [
      brave
      vscode.fhs
      nixpkgs-fmt
      nixd
      gnome-tweaks
      nautilus
    ];
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      show-battery-percentage = true;
    };

    "org/gnome/desktop/search-providers" = {
      disable-external = true;
    };

    "org/freedesktop/tracker/miner/files" = {
      index-single-directories = [];
      index-recursive-directories = [];
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
  };

  programs = {
    git = {
      enable = true;
      userName = "Pedro Cardoso da Silva (@forsureitsme)";
      userEmail = "forsureitsme@gmail.com";
    };

    alacritty = {
      enable = true;
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
  };
}
