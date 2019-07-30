{ config, pkgs, ... }:
{
  programs.zsh = {
    interactiveShellInit = ''
      source ${pkgs.zsh-powerlevel9k}/share/zsh-powerlevel9k/powerlevel9k.zsh-theme
    '';
  };
}
