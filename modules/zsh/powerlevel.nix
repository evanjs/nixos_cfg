{ config, pkgs, ... }:
{
  programs.zsh = {
    promptInit = ''
      source ${pkgs.zsh-powerlevel9k}/share/zsh-powerlevel9k/powerlevel9k.zsh-theme
    '';
  };
}
