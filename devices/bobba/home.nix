{
  pkgs,
  params,
  config,
  ...
}:
with config; let
  # Until v0.2024.11.19.08.02 goes to nixpkgs
  warpWithoutLogin = pkgs.warp-terminal.overrideAttrs rec {
    pname = "warp-terminal";
    version = "0.2024.11.19.08.02.stable_01";
    src = pkgs.fetchurl {
      url = "https://releases.warp.dev/stable/v${version}/warp-terminal-v${version}-1-x86_64.pkg.tar.zst";
      sha256 = "sha256-4uYVA+6NI11X/rYwEzHeTiPnDyntpZcBBBCiZkc9ik8=";
    };
  };
in {
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

  home.packages = with pkgs;
    [
      brave

      # Clipboard support for nvim
      xclip

      # Enable pseudo media function keys
      pulseaudio
      brightnessctl
    ]
    ++ [
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
}
