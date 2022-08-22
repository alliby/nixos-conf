{ pkgs, ...}: {

  users.users.cargo.packages = with pkgs; [
    firefox
    alacritty
    htop
    onlyoffice-bin
    xclip
  ];
}
