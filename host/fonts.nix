{
  pkgs,
  ...
}: {
  fonts = {
    packages = with pkgs; [
      iosevka-bin
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      jetbrains-mono
      fira-code
    ];

    enableDefaultPackages = false;
    # this fixes emoji stuff
    fontconfig = {
      enable = true;
      includeUserConf = true;
      defaultFonts = {
        sansSerif = [
          "Noto Sans"
          "Noto Naskh Arabic UI"
        ];
        serif = [
          "Noto Serif"
          "Noto Naskh Arabic UI"
        ];
        monospace = ["Iosevka" ];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
