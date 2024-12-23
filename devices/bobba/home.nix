{
  pkgs,
  params,
  config,
  ...
}:
with config; {
  # Start windows maximized
  services.devilspie2 = {
    enable = true;
    config = ''
      maximize()
    '';
  };

  # Symlink configs
  systemd.user.tmpfiles.rules =
    map (
      path: "L+ ${home.homeDirectory}/${path} - - - - ${home.homeDirectory}/nixos/dotfiles/${path}"
    ) [
      ".config/xfce4/"
      ".config/warp-terminal/"
      ".local/share/warp-terminal/"
    ];

  home.packages = with pkgs; [
    brave
    warp-terminal

    # Clipboard support for nvim
    xclip

    # Enable pseudo media function keys
    pulseaudio
    brightnessctl
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
}
