{ pkgs, ... }: {

  environment.variables = {
    
    # Scaling
    GDK_SCALE = "1.4";
    GDK_DPI_SCALE = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";

    # Set Helix as Default Editor
    EDITOR = "hx"; 
    TERMINAL = "alacritty";

  };

  # session variables
  environment.sessionVariables = {
    # Add Home Manager To Path
    # NIX_PATH = [ "\$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels\${NIX_PATH:\+:\$NIX_PATH}" ];

    # XDG Variables
    XDG_CACHE_HOME  = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";

  };
}
