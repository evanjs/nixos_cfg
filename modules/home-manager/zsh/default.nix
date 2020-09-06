{ config, pkgs, ... }:
{
  home-manager.users.evanjs = {

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
  };
}
