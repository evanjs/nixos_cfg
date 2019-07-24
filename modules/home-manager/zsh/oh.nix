{ config, ... }:
{
  programs.zsh.oh-my-zsh = {
    enable = true;
    plugins = [
      "catimg"
      "emoji"
      "fd"
      "git"
      "ng"
      "ripgrep"
      "rust"
      "sudo"
      "systemd"
      "z"
    ];
    theme = "agnoster";
  };
}
