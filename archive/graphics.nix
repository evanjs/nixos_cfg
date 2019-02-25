{ config, pkgs, ... }:
{

  hardware = {
    nvidia = {
      modesetting.enable = true;
    };
    opengl = {
      extraPackages = with pkgs; [ vaapiIntel libvdpau-va-gl vaapiVdpau intel-ocl ];
      extraPackages32 = with pkgs; [ vaapiIntel libvdpau-va-gl vaapiVdpau intel-ocl];
    };
  };
}
