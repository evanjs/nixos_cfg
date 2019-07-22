{ config, pkgs, ... }:
{
  environment = {
    pathsToLink = [ "/share/zsh" ];
  };

  programs.zsh = {
    enable = true;
  };

  # enable completion for system packages (e.g. systemd)
  users.users.evanjs.shell = pkgs.zsh;
  
  fonts.fonts = with pkgs; [
    powerline-fonts
  ];
}
