{ config, pkgs, lib, ... }:
{
  imports = [
    ./autolock.nix
    ./flashback-xmonad.nix
    ../virtualgl.nix
  ];

  sound.mediaKeys.enable = true;

  services.xserver = {
    desktopManager.xterm.enable = false;
    displayManager = {
      gdm = {
        debug = true;
        enable = true;
        xmonad-support.enable = false;
      };
      lightdm.enable = false;
    };
    exportConfiguration = true;
    windowManager = {
      default = "xmonad";
      xmonad.enable = true;
    };
  };

  services.compton = {
    vSync = true;
  };
}

