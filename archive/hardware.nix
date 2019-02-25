{ config, pkgs, ... }:
{
  hardware = {
    bluetooth = {
      enable = true;
    };
    pulseaudio = {
      package = pkgs.pulseaudioFull;
    };
  };

  environment.systemPackages = with pkgs; [
    pavucontrol
  ];
}
