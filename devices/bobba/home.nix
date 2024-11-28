{ pkgs, params, config, ... }:
with config; let
  # Until v0.2024.11.19.08.02 goes to nixpkgs
  warpWithoutLogin = pkgs.warp-terminal.overrideAttrs (rec {
    pname = "warp-terminal";
    version = "0.2024.11.19.08.02.stable_01";
    src = pkgs.fetchurl {
      url = "https://releases.warp.dev/stable/v${version}/warp-terminal-v${version}-1-x86_64.pkg.tar.zst";
      sha256 = "sha256-4uYVA+6NI11X/rYwEzHeTiPnDyntpZcBBBCiZkc9ik8=";
    };
  });
in {
  # Start windows maximized
  services.devilspie2 = {
    enable = true;
    config = ''
      maximize()
    '';
  };

  # Symlink configs
  systemd.user.tmpfiles.rules = [
    "L+ ${home.homeDirectory}/.config/xfce4/ - - - - ${home.homeDirectory}/nixos/dotfiles/.config/xfce4/"
  ];

  home.packages = with pkgs; [
    brave

    xclip # Clipboard support for nvim
    # Function Keys
    pulseaudio
    brightnessctl 
  ] ++ [
    warpWithoutLogin
  ];

  # TODO: Check if every settings was migrated to xfce
  # dconf.settings = {
  #   "org/gnome/desktop/background" = {
  #     picture-uri-dark = "file://${(pkgs.fetchurl {
  #       url = "https://pm1.aminoapps.com/6612/3a75e0d96b11a5083c1b4a87fc795f04f7b036b7_hq.jpg";
  #       hash = "sha256-s1+li8Hyp8zfO2GArgCyYgkwV96LfmH7Tzn0Y/iIMFM=";
  #     })}";
  #   };

  #   "org/gnome/desktop/interface" = {
  #     color-scheme = "prefer-dark";
  #     enable-hot-corners = false;
  #     show-battery-percentage = true;
  #   
  #     font-name = "Ubuntu Nerd Font 11";
  #     monospace-font-name = "UbuntuMono Nerd Font 10";
  #     document-font-name = "Ubuntu Nerd Font 10";
  #   };

  #   "org/gnome/desktop/search-providers" = {
  #     disable-external = true;
  #   };

  #   "org/freedesktop/tracker/miner/files" = {
  #     index-single-directories = [ ];
  #     index-recursive-directories = [ ];
  #   };

  #   "org/gnome/desktop/privacy" = {
  #     remember-recent-files = false;
  #     remove-old-trash-files = true;
  #     remove-old-temp-files = true;
  #     old-files-age = 0;
  #   };

  #   "org/gnome/mutter" = {
  #     dynamic-workspaces = true;
  #   };

  #   "org.gnome.settings-daemon.plugins.power" = {
  #     idle-dim = true;
  #     power-saver-profile-on-low-battery = false;
  #     power-button-action = "nothing";
  #     sleep-inactive-ac-type = "nothing";
  #     sleep-inactive-battery-type = "nothing";
  #   };

  #   "org/gnome/shell/extensions/blur-my-shell" = {
  #     hacks-level = 0;
  #   };
  # };
}
