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

      initExtra = ''
        POWERLEVEL9K_MODE="nerdfont-complete";
        source ${pkgs.zsh-powerlevel9k}/share/zsh-powerlevel9k/powerlevel9k.zsh-theme
      '';
      history.size = 1000000;
    };
  };
}
