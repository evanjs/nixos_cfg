{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.mine.taffybar;
in {

  options.mine.taffybar = {
    enable = mkEnableOption "taffybar config";
    package = mkOption {
      description = "The taffybar package to use";
      default = (import ./taffybar { inherit pkgs; }).taffybar;
      example = pkgs.taffybar;
    };
  };

  config = mkIf cfg.enable {

    services.upower.enable = true;

    mine.xUserConfig = {
      services.taffybar = {
        enable = true;
        package = cfg.package;
      };
    };
  };
}
