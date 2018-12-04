{ config, pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    virtualgl
    ];

  users.users.evanjs.extraGroups = [ "video" "vglusers" ];
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
