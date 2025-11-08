{ config, lib, pkgs, inputs, ... }:
{
  # Plasma
  services.displayManager.sddm.wayland.enable = true;
  services.xserver.enable = true;
  services = {
    desktopManager = {
      plasma6 = {
        enable = true;
      };
    };
    displayManager = {
      sddm.enable = true;
      #gdm.enable = true;
      #gdm.xmonad-support = false;
    };
    xserver.windowManager = {
      xmonad.enable = false;
      #default = "plasma";
    };
  };
}
