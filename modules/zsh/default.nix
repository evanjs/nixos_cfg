{ config, pkgs, ... }:
{

  imports = [
    ./oh.nix
  ];

  environment = {
    pathsToLink = [ "/share/zsh" ];
  };

  programs.zsh = {
    autosuggestions = {
      enable = true;
    };
    syntaxHighlighting = {
      enable = true;
    };
    enable = true;
  };

  # enable completion for system packages (e.g. systemd)
  users.users.evanjs.shell = pkgs.zsh;
  
  fonts.fonts = with pkgs; [
    powerline-fonts
  ];
}
