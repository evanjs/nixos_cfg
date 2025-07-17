{ config, pkgs, ... }:
{
  services.xserver = {
    videoDrivers = [ "amdgpu" ];
  };


  hardware = {
    opengl = {
      extraPackages = with pkgs; [ libvdpau-va-gl vaapiVdpau ];
      extraPackages32 = with pkgs; [ libvdpau-va-gl vaapiVdpau ];
    };
  };
}
