{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    home-manager
  ];
  
  services.dbus.packages = with pkgs; [ gnome3.dconf ];
}
