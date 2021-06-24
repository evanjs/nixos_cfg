{ pkgs, lib, config, ... }:

with lib;
let

  cfg = config.mine.terminal;
  spacecamp-kitty = pkgs.fetchFromGitHub {
    owner = "sebastianks";
    repo = "spacecamp-kitty";
    rev = "c06cc6f56076fb04aee04bc466c7733e6234b652";
    sha256 = "0zwvjanph8bkw2pjbicsk3cifn2gmm6c9l4x6dgr4iaf8yf8ks1b";
  };
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
          font.name = "${config.mine.fonts.mainFont.name}";
          font.package = config.mine.fonts.mainFont.package;
          settings = {
            window_padding_width = "4 8";
          };
          extraConfig = ''
            include ${spacecamp-kitty}/spacecamp.conf
          '';
        };

      home.file.".tmux.conf".text = ''
        set -g default-terminal "xterm-256color"
        set -g destroy-unattached "on"
      '';

    };
  };
}
