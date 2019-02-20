{ config, pkgs, ... }:
{
  imports = [
    ./unstable.nix
    ];
  environment.systemPackages = with pkgs; [
    steam
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
