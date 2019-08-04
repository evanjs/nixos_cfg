{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    weechat
  ];
}
