{ pkgs, lib, config, ... }:

with lib;

let

  cfg = config.mine.terminal;

in

{

  options.mine.terminal = {

    enable = mkEnableOption "My terminal";

    binary = mkOption {
      type = types.path;
      description = "Path to terminal binary";
    };

  };

  config = mkIf cfg.enable {

    mine.terminal.binary = "${pkgs.kitty}/bin/kitty";

    environment.systemPackages = [
      pkgs.kitty
      pkgs.tmux
      pkgs.screen
    ];

    mine.xUserConfig = {

      xdg.configFile."kitty/kitty.conf".source = ./kitty.conf;

      home.file.".tmux.conf".text = ''
        set -g default-terminal "xterm-256color"
        set -g destroy-unattached "on"
      '';

    };

  };

}
