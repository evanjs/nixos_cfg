{ config, pkgs, ... }:
let
  vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  openglPackages = with pkgs; [ vaapiIntel vaapiVdpau libvdpau-va-gl ];
in
{
  environment.systemPackages = with pkgs; [
    xorg.xbacklight
    xorg.xf86videointel
  ];

  hardware.opengl = {
    extraPackages32 = openglPackages;
    extraPackages = openglPackages;
  };
  services.xserver = {
    #useGlamor = true;
    deviceSection = ''
      Option "DRI" "2"
      Option "TearFree" "True"
    '';
  };
}
