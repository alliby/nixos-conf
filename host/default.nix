{ ... }: {
  imports = [
    ./system.nix
    ./hardware-configuration.nix
    ./environment.nix
    ./graphics.nix
    ./fonts.nix
    ./nix.nix
    ./power.nix
  ];
}

