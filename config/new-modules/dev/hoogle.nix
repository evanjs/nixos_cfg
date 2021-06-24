{ lib, config, pkgs, ... }:

with lib;

let
  hpkgs = config.mine.xUserConfig.xsession.windowManager.xmonad.haskellPackages;
  cfg = config.mine.dev.haskell.hoogle;
in
  {
    options.mine.dev.haskell.hoogle = {
      enable = mkEnableOption "Hoogle documentation server";
    };
    config = mkIf (cfg.enable && config.mine.dev.haskell.enable) {

      services.hoogle = {
        enable = true;
        port = 8471;
        packages = hp: with pkgs; [
          #(stable.haskellPackages.taffybar.overrideAttrs (drv: {
          #  meta.broken = false;
          #}))
          #config.mine.taffybar.package
          hp.xmobar
          xmonad-with-packages
          hp.xmonad
          hp.xmonad-contrib
        ];
      };

      networking.firewall.allowedTCPPorts = [
        config.services.hoogle.port
      ];

      environment.systemPackages = with hpkgs; [
        hpkgs.hoogle
      ];
    };
  }
