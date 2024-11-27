{ pkgs, params, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable Intel GPU Acceleration
  hardware.graphics.extraPackages = with pkgs; [
    intel-compute-runtime
    intel-media-driver
  ];

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    displayManager.lightdm = {
      enable = true;
      greeter.enable = true;
    };
    desktopManager.xfce.enable = true;

    # Remove xterm from bloated desktop manager install
    excludePackages = [ pkgs.xterm ];
    desktopManager.xterm.enable = false;

    # Enable Intel graphic drives
    videoDrivers = [ "modesetting" ];

    # Configure keymap in X11
    xkb = {
      layout = "br";
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
  services.displayManager.autoLogin = {
    enable = true;
    user = params.user;
  };

  # Map keys
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          shift = {
            # Missing keys
            backspace = "delete";
            power = "S-insert";
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
      (nerdfonts.override { fonts = ["Ubuntu" "UbuntuMono"]; })
    ];
    fontDir = {
      enable = true;
    };
  };
}
