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
        POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
        POWERLEVEL9K_MODE="nerdfont-complete"
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      '';
      history.size = 1000000;
    };
  };
}
