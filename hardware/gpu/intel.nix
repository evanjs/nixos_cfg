{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    xorg.xbacklight
    xorg.xf86videointel
  ];

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  hardware.opengl.extraPackages = with pkgs; [
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl
    intel-media-driver
  ];
  services.xserver = {
    useGlamor = true;
    deviceSection = ''
      Option "DRI" "2"
      Option "TearFree" "True"
    '';
  };
}
