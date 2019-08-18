{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    rfkill
  ];

  # Bluetooth
  hardware.bluetooth.enable = true;
}
