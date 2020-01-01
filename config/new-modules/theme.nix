{ config, lib, ... }:

with lib;
let
  cfg = config.mine.theme;

in
  {
    options.mine.theme = {
      enable = mkEnableOption "theme options";
      darkTheme.enable = mkOption {
        default = true;
        example = false;
        description = "Enable dark theme";
      };
    };

    config = mkIf cfg.enable {
      mine.userConfig.gtk = mkIf cfg.gtk.enable {
        gtk2.extraConfig = lib.optionalString cfg.darkTheme.enable ''
          gtk-application-prefer-dark-theme = true
        '';
        gtk3.extraConfig = lib.optional cfg.darkTheme.enable {
          gtk-application-prefer-dark-theme = true;
        };
      };
    };
  }
