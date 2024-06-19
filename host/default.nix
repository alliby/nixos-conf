{ ... }: {
  imports = [
    ./system.nix
    ./hardware-configuration.nix
    ./environment.nix
    ./power-manager.nix
    ./graphics.nix
    ./fonts.nix
    ./nix.nix
  ];
}

