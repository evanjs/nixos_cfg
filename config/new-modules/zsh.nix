{ lib, config, pkgs, ... }:
with lib;

mkIf config.mine.console.enable {

  mine.userConfig = {
    home.packages = with pkgs; [
      colormake
      colordiff
    ];

    home.sessionVariables.EDITOR = "vim";

    home.sessionVariableSetter = "zsh";

    programs.zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
      };

      initExtra = ''
        POWERLEVEL9K_MODE="nerdfont-complete";
        source ${pkgs.zsh-powerlevel9k}/share/zsh-powerlevel9k/powerlevel9k.zsh-theme
      '';
      history.size = 1000000;
    };
  };
}
