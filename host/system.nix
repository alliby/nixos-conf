{
  pkgs,
  inputs,
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
    package = pkgs.bluez;
    powerOnBoot = false;
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

  # X11 windowing system.
  services.xserver = {
    enable = false;
    excludePackages = [ pkgs.xterm ];
    displayManager.lightdm.enable = false;
    xkb = {
      layout = "gb,ara";
      options = "grp:win_space_toggle";
    };
  };

  # Sound
  services.pipewire.enable = false;
  hardware.pulseaudio.enable = true;

  # Autologin
  services.greetd.enable = true;
  services.greetd.settings.default_session.command = "${pkgs.greetd.greetd}/bin/agreety --cmd ${pkgs.bashInteractive}/bin/bash";	
  services.greetd.settings.initial_session.user = "cargo";
  services.greetd.settings.initial_session.command = "sway > ~/.sway.log 2>&1";

  # Printing
  services.printing.enable = false;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  services.libinput.touchpad.naturalScrolling = true;

  # Dbus
  services.dbus.enable = true;
  
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
  programs.dconf.enable = true;

  # Auto mount USBs
  # services.udisks2.enable = true;
}
