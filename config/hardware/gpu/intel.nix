{ config, pkgs, ... }:
let
  vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
in
{
  environment.systemPackages = with pkgs; [
    xorg.xbacklight
    xorg.xf86videointel
  ];

  hardware.opengl = {
    extraPackages = with pkgs; [
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-media-driver
    ];
  };
  services.xserver = {
    useGlamor = true;
    deviceSection = ''
      Option "DRI" "2"
      Option "TearFree" "True"
    '';
  };
}
