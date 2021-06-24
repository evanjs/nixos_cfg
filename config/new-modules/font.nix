{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.mine.fonts;
in
{
  options.mine.fonts = rec {
    bar = rec {
      # description = "Settings related to fonts for status bars";
      size = {
        #description = "The font sizes to use for status bars";
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
    mainFont = rec {
      mono = rec {
        name = mkOption {
          description = "The name of the main mono font to use";
          default = "${cfg.mainFont.name} Mono";
          example = "JetBrainsMono Nerd Font Mono";
          type = lib.types.str;
        };
      };
      name = mkOption {
        description = "The main name of the font";
        default = "JetBrainsMono Nerd Font";
        type = types.str;
      };
      package = mkOption {
        description = "The main font package to use";
        default = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "FiraMono" "Noto" ]; });
        example = pkgs.jetbrains-mono;
        type = types.package;
      };
    };
    fallbackFonts = rec {
      packages = mkOption {
        type = types.listOf types.package;
        description = "Fallback font packages to use";
        default = with pkgs; [ noto-fonts-cjk ];
        example = with pkgs; [ noto-fonts-emoji ];
      };
      names = mkOption {
        type = types.listOf types.str;
        description = "A list of the names of fallback fonts to use";
        default = [ "Noto Sans Mono CJK JP" ];
        example = [ "Noto Sans Mono CJK KR" ];
      };
    };
    package = mkOption {
      type = types.package;
      description = "The package of the font to use";
      default = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "FiraMono" "Noto" ]; });
    };
  };

  config = {
    fonts.fonts = [
      cfg.package
    ] ++ cfg.fallbackFonts.packages;
  };
}
