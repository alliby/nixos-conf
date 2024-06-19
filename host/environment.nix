{ ... }: {
  environment.variables = {
    # Set Helix as Default Editor
    EDITOR = "hx"; 
    TERMINAL = "alacritty";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
