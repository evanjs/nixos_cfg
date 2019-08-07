{ config, pkgs, ... }:
{
  programs.zsh = {
    promptInit = ''
      POWERLEVEL9K_MODE="nerdfont-complete";
      source ${pkgs.zsh-powerlevel9k}/share/zsh-powerlevel9k/powerlevel9k.zsh-theme
    '';
  };
}
