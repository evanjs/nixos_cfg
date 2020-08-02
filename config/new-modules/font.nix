{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.mine.font;
in
{
  options.mine.font = rec {
    bar = {
      description = "Settings related to fonts for status bars";
      size = {
        description = "The font sizes to use for status bars";
        small = mkOption {
          description = "Font size to use for traditionally smaller bars, often text-based bars, such as xmobar";
          default = 8;
          type = types.int;
        };
        large = mkOption {
          description = "Font size to use for traditionally larger, often GUI-centric bars, such as taffybar";
          default = 10;
          type = types.int;
        };
      };
    };
    name = mkOption {
      description = "The name of the font";
      default = "JetBrainsMono Nerd Font";
      type = types.str;
    };
    package = mkOption {
      description = "The package of the font to use";
      default = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "FiraMono" "Noto" ]; });
      type = types.package;
    };
  };

  config = {
    fonts.fonts = [
      cfg.package
    ];
  };
}
