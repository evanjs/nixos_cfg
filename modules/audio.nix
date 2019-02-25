{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pavucontrol
  ];

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  sound.mediaKeys.enable = true;
}
