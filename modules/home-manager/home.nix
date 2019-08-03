{ config, pkgs, ... }:
{
  imports = [
    ./compton.nix
    ./email.nix
    ./firefox.nix
    ./fonts.nix
    ./git.nix
    ./lib.nix
    ./lsd.nix
    ../jetbrains.nix
    ./randr
    ./rofi.nix
    ./security
    ./security/gpg.nix
    ./services
    ./skim.nix
    ./style
    ./tmux.nix
    ./xorg

    # shells
    ./bash
    ./zsh
  ];

  home = {
    sessionVariables = config.lib.sessionVariables;
  };

  programs = {
    home-manager = {
      enable = true;
    };
  };
}
