{ config, pkgs, lib, ... }:

with lib;

{

  options = { mine.wm.enable = mkEnableOption "My window manager"; };

  config = mkIf config.mine.wm.enable rec {

    services.xserver.windowManager.xmonad =
      let userConfig = mine.xUserConfig.xsession.windowManager.xmonad;
      in {
        enable = userConfig.enable;
        extraPackages = userConfig.extraPackages;
        haskellPackages = userConfig.haskellPackages;
        enableContribAndExtras = userConfig.enableContribAndExtras;
        config = userConfig.config;
      };

    mine.xmobar.enable = true;
    mine.taffybar.enable = true;
    mine.terminal.enable = true;

    scripts = {
      emacs = ''
        if ! [ $(systemctl --user is-active emacs) = active ]; then
        systemctl --user start emacs
        fi
        emacsclient -c -n
      '';
      terminal = "kitty";
      xmobar = config.mine.xmobar.command;
      zeal = "${pkgs.zeal}/bin/zeal";
    };

    mine.userConfig = { home.packages = [ pkgs.maim ]; };

    mine.xUserConfig = {

      xsession.windowManager.xmonad = {
        enable = true;
        extraPackages = self: with self; [
          fuzzy
          taffybar
        ];
        haskellPackages = pkgs.stable.haskell.packages.ghc865;
        enableContribAndExtras = true;
        config = pkgs.runCommand "xmonad.hs" (config.scripts // {
          spacing = if config.mine.hardware.battery then "False" else "True";
        }) "substituteAll ${./xmonad.hs} $out";
      };
    };
  };
}
