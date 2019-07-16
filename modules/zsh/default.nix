{ config, pkgs, ... }:
{
  environment = {
    pathsToLink = [ "/share/zsh" ];
  };

  # enable completion for system packages (e.g. systemd)
  users.users.evanjs.shell = pkgs.zsh;
  
  fonts.fonts = with pkgs; [
    powerline-fonts
  ];
}
