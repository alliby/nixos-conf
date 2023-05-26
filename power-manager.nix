{ config, pkgs, ... }:
{
  services.upower.enable = true;
  services.upower.percentageCritical = 20;
  hardware.system76.power-daemon.enable = true;
  
  # Opengl
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      vaapi-intel-hybrid
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      libva
      vaapiIntel
    ];
  };

  # NVIDIA drivers are unfree.
  nixpkgs.config.allowUnfree = true;

  # services.xserver.videoDrivers = [ "nvidia" ];

  environment.systemPackages = [ 
    pkgs.vulkan-loader
    pkgs.vulkan-headers
    pkgs.vulkan-tools
    pkgs.vulkan-validation-layers
    pkgs.spirv-tools
    config.boot.kernelPackages.nvidiaPackages.stable
  ];

}
