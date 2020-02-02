{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.mine.font;
in
{
  options.mine.font = {
    name = mkOption {
      description = "The name of the font";
      default = "JetBrains Mono";
      type = types.str;
    };
    package = mkOption {
      description = "The package of the font to use";
      default = pkgs.jetbrains-mono;
      type = types.package;
    };
  };

  config = {
    fonts.fonts = [
      cfg.package
    ];
  };
}
