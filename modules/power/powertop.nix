{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    powertop
  ];

  powerManagement = {
    powertop = {
      enable = true;
    };
  };
}
