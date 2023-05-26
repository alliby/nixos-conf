# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # ./video-configuration.nix
      ./environment.nix
      ./programs.nix
      ./fonts.nix
      ./power-manager.nix
      # ./hyprland.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda"; # or "nodev" for efi only
    theme = null;
    backgroundColor = null;
    splashImage = null;
  };

  # Networking
  networking = {
    hostName = "nix"; # Define your hostname.
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.
    usePredictableInterfaceNames = false;
    nameservers = [ "1.1.1.1" ]; # Change Dns Resolver
  };
  systemd.services.NetworkManager-wait-online.enable = false; # slows down boot time

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Algiers";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    dpi = 140;
    excludePackages = [ pkgs.xterm ];

    # Tiling Windows Manager
    windowManager.bspwm.enable = true;

    # Configure keymap in X11
    layout = "us,ar";
    # See Full Keyboard Layout Keybinds "grep "grp:.*toggle" /usr/share/X11/xkb/rules/base.lst"
    xkbOptions = "grp:alt_shift_toggle";

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
    libinput.touchpad.naturalScrolling = true;
  };

  # Enable sound.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cargo = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "render" "bluetooth" ];
  };

  # Disable sudo
  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [{
    users = [ "cargo" ];
    keepEnv = true;
    persist = true;
  }];  

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    acpi
    pciutils
    brightnessctl
    git
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  fonts.fontDir.enable = true;
  services.xserver.displayManager.lightdm.background = /home/cargo/.local/share/wallhaven/wallhaven-m9wp81.jpg;

}
