{ config, pkgs, ... }:
{
  imports = [
    ./powerlevel.nix
  ];

  home.packages = with pkgs; [
    zsh-you-should-use
  ];

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    history = {
      extended = true;
      share = false;
    };
    initExtra = ''
      source ${pkgs.zsh-powerlevel9k}/share/zsh-powerlevel9k/powerlevel9k.zsh-theme
    '';
  };
}
