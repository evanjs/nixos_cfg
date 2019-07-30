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
  };
}
