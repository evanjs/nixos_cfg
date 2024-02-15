{ config, pkgs, ... }:
{
  services.xserver = {
    videoDrivers = [ "amdgpu" ];
  };


  hardware = {
    opengl = {
      extraPackages = with pkgs; [
        libvdpau-va-gl
        vaapiVdpau
        amdvlk
      ];
      extraPackages32 = with pkgs; [
        libvdpau-va-gl
        vaapiVdpau
        driversi686Linux.amdvlk
      ];
    };
  };
}
