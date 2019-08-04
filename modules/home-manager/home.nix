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

  home-manager.users.evanjs = {
    home = {
      sessionVariables = config.home-manager.users.evanjs.lib.sessionVariables;
    };
  };
}
