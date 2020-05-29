{ config, pkgs, ... }:
{
  home-manager.users.evanjs = {

    imports = [
      ./zsh.nix
      ./powerlevel.nix
    ];
  };
}
