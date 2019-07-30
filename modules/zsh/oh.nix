{ config, pkgs, lib, ... }:
with lib;
{
  environment.systemPackages = with pkgs; [
    tmux
  ];

  programs.zsh = {
    ohMyZsh = {
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
