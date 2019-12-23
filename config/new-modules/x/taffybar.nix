{ config, pkgs, lib, ... }:

with lib;

let

in {

  options.mine.taffybar.enable = mkEnableOption "taffybar config";

  config = mkIf config.mine.taffybar.enable {

    services.upower.enable = true;

    mine.xUserConfig = {
      services.taffybar = {
        enable = true;
        package = (import ./taffybar { inherit pkgs; }).taffybar;
      };
    };
  };
}
