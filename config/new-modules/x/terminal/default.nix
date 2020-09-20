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

  config =
    let
      kitty = lib.findFirst (p: (lib.getName p) == "kitty") { } config.mine.xUserConfig.home.packages;
    in
    mkIf cfg.enable {

      mine.terminal.binary = "${kitty}/bin/kitty";

    environment.systemPackages = [
      pkgs.tmux
      pkgs.screen
    ];

      mine.xUserConfig = {
        programs.kitty = {
          enable = true;
          font.name = "${config.mine.font.name}";
          font.package = config.mine.font.package;
        };

      home.file.".tmux.conf".text = ''
        set -g default-terminal "xterm-256color"
        set -g destroy-unattached "on"
      '';

    };
  };
}
