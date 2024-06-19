{
  pkgs,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;
  
  # Networking
  networking = {
    hostName = "unix"; # Define your hostname.
    nameservers = ["1.1.1.1" "8.8.8.8"]; # Change Dns Resolver
    usePredictableInterfaceNames = false;
    networkmanager.enable = true;
    networkmanager.wifi.powersave = true;
  };
  systemd.services.NetworkManager-wait-online.enable = false; # slows down boot time

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez.override { withExperimental = true; };
    settings = {
      General = {
        Experimental = true;
      };
    };
  };
  

  # Set your time zone.
  time.timeZone = "Africa/Algiers";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    excludePackages = [ pkgs.xterm ];

    # # Tiling Windows Manager
    windowManager.bspwm.enable = true;
    windowManager.i3.enable = true;

    # # Configure keymap in X11
    # # See Full Keyboard Layout Keybinds "grep "grp:.*toggle" /usr/share/X11/xkb/rules/base.lst"
    xkb = {
      layout = "us,ara";
      options = "grp:alt_shift_toggle";
    };

    # # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
    libinput.touchpad.naturalScrolling = true;
  };

  # Enable sound.
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cargo = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "audio" "video" "render" "bluetooth" "dialout" "input" "aspizu" ];
  };

  # Disable sudo
  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [
    {
      users = ["cargo"];
      keepEnv = true;
      persist = true;
    }
  ];

  services.xserver.displayManager = {
    defaultSession = "none+i3";
    autoLogin = {
      enable = true;
      user = "cargo";
    };
  };
  programs.dconf.enable = true;
}
