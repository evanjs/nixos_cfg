{ lib, config, pkgs, ... }:

with lib;

let

  cfg = config.mine.dev.hoogle;
in
  {
    options.mine.dev.hoogle = {
      enable = mkEnableOption "Hoogle documentation server";
    };
    config = mkIf cfg.enable {

      services.hoogle = {
        enable = true;
        port = 8471;
        packages = hp: with pkgs; [
          (stable.haskellPackages.taffybar.overrideAttrs (drv: {
            meta.broken = false;
          }))
          config.mine.taffybar.package
          xmonad-with-packages
          hp.xmonad
          hp.xmonad-contrib
        ];
      };

      environment.systemPackages = with pkgs; [
        haskellPackages.hoogle
      ];
    };
  }
