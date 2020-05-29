{ lib, config, pkgs, ... }:
with lib;

mkIf config.mine.console.enable {

  programs.zsh.syntaxHighlighting.enable = true;

  mine.userConfig = {
    imports = [
      ./zsh-home-manager.nix
    ];
  };
}
