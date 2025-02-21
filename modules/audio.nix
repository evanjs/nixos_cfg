{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pavucontrol
  ];

  services.pipewire.enable = false;

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  #sound.mediaKeys.enable = true;
}
