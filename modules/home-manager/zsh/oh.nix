{ config, lib, ... }:
with lib;
{
  programs.zsh = {

    initExtra = ''
      autoload -U compinit && compinit
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [
        "catimg"
        "emoji"
        "fd"
        "git"
        "ng"
        "ripgrep"
        "rust"
        "screen"
        "sudo"
        "systemd"
        "tmux"
      ];
      theme = "agnoster";
    };
  };
}
