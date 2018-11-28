{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pkgs.steam
  ];
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    pulseaudio.support32Bit = true;
  };
}
