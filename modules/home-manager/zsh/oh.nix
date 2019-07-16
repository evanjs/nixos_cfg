{ config, ... }:
{
  programs.zsh.oh-my-zsh = {
    enable = true;
    plugins = [
      "catimg"
      "emoji"
      "fd"
      "git"
      "jira"
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
