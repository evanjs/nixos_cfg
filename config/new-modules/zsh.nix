{ lib, config, pkgs, ... }:
with lib;

mkIf config.mine.console.enable {

  programs.zsh.syntaxHighlighting.enable = true;

  mine.userConfig = {
    home.packages = with pkgs; [
      colormake
      colordiff
    ];

    programs.zsh = {
      enable = true;
      history = {
        extended = true;
        share = false;
      };

      history.size = 1000000;
    };
  };
}
