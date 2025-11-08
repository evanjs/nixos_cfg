{ config, lib, pkgs, inputs, ... }:
{
  home-manager.users.evanjs = {
    programs.waybar = {
      enable = true;
      systemd = {
        enable = true;
      };
    };
    #home.packages = with pkgs; [
      #waybar
    #];
  };

  fonts.packages = with pkgs; [
    font-awesome_7
  ];
}
