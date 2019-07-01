{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    powertop
  ];

  powerManagement = {
    powertop = {
      /*
      * currently, powertop does not have any (nixos) options, and does not base its behavior
      * on the power source, so Autosuspend is always on, etc
      * disable until this can be configured
      * e.g. Do not autosuspend USB devices if connected to AC power
      */
      #enable = false;
    };
  };
}
