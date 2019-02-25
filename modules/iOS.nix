{ config, pkgs, ... }:
{
  # iDevice utilities
  services.usbmuxd.enable = true;
}
