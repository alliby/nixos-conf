{ pkgs, ...}:
# let
#   pkgsUnstable = import <nixpkgs-unstable> {};
# in
{
  # users.users.cargo.shell = pkgsUnstable.nushell;
  users.users.cargo.packages = with pkgs; [
    alacritty
    xclip
  ];
}
