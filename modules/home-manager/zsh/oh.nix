{ config, ... }:
{
  programs.zsh = {
    oh-my-zsh = {
      enable = false;
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
      ];
      theme = "agnoster";
    };
  };
}
