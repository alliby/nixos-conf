{  pkgs, ... }:
{
  # Opengl
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      libvdpau-va-gl
    ];
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; }; # Force intel-media-driver

  environment.systemPackages = with pkgs; [ 
    vulkan-loader
    vulkan-headers
    vulkan-tools
    vulkan-validation-layers
    spirv-tools  
    libva-utils
    linux-firmware
  ];

}
