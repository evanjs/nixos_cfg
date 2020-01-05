{ config, pkgs, ... }:
{
  imports = [
    ./email.nix
    ./firefox.nix
    #./fonts.nix
    ./git.nix
    ./lib.nix
    ./lsd.nix
    ./randr
    ./rofi.nix
    ./security
    #./security/gpg.nix
    ./services
    ./skim.nix
    ./tmux.nix

    ./bash
  ];

  home-manager.users.evanjs = {
    home = {
      sessionVariables = config.home-manager.users.evanjs.lib.sessionVariables;
    };
  };
}
