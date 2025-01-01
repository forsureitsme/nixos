{
  nixpkgs,
  pkgs,
  params,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 3;
    };
    timeout = 1;
    efi.canTouchEfiVariables = true;
  };

  # Enable Intel GPU Acceleration
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override {enableHybridCodec = true;};
  };
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    desktopManager.xfce.enable = true;

    # Remove xterm from bloated desktop manager install
    excludePackages = [pkgs.xterm];
    desktopManager.xterm.enable = false;

    # Enable Intel graphic drives
    videoDrivers = ["modesetting"];

    # Configure keymap in X11
    xkb = {
      layout = "br";
    };
  };

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "matrix";
      hide_borders = true;
    };
  };
  # Remove bloat
  environment.xfce.excludePackages = with pkgs.xfce; [
    xfdesktop
    mousepad
    parole
    ristretto
  ];

  # Enable automatic login for the user.
  # services.displayManager.autoLogin = {
  #   enable = true;
  #   user = params.user;
  # };

  # Map keys
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = ["*"];
        settings = {
          shift = {
            backspace = "delete";
            power = "S-insert";
          };
          main = {
            capslock = "layer(meta)";
            back = "f1";
            forward = "f2";
            refresh = "f3";
            zoom = "f4";
            scale = "f5";
            brightnessdown = "f6";
            brightnessup = "f7";
            mute = "f8";
            volumedown = "f9";
            volumeup = "f10";
            power = "f11";
          };
          meta = {
            up = "pgup";
            down = "pgdown";
            left = "home";
            right = "end";
            f1 = "back";
            f2 = "forward";
            f3 = "refresh ";
            f4 = "zoom";
            f5 = "scale";
            f6 = "brightnessdown ";
            f7 = "brightnessup ";
            f8 = "mute ";
            f9 = "volumedown ";
            f10 = "volumeup";
          };
          # ? = PgUp PgDown
        };
      };
    };
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable bluetooth management
  hardware.bluetooth = {
    enable = true;
  };
  services.blueman.enable = true;

  # Unlame tty console
  services.kmscon = {
    enable = true;
    hwRender = true;
    useXkbConfig = true;
  };

  # Fonts
  fonts = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["Ubuntu" "UbuntuMono"];})
    ];
    fontDir = {
      enable = true;
    };
  };
}
