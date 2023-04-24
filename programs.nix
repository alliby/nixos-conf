{ pkgs, ...}: {

  users.users.cargo.packages = with pkgs; [
    alacritty
    xclip
  ];
}
