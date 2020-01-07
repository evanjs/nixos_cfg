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
        enableContribAndExtras = userConfig.enableContribAndExtras;
        config = userConfig.config;
      };

    mine.xmobar.enable = true;
    mine.taffybar.enable = true;
    mine.compton = {
      enable = true;
      highend = true;
    };
    mine.terminal.enable = true;

    scripts = {
      emacs = ''
        if ! [ $(systemctl --user is-active emacs) = active ]; then
        systemctl --user start emacs
        fi
        emacsclient -c -n
      '';
      xmobar = config.mine.xmobar.command;
    };

    mine.userConfig = { home.packages = [ pkgs.maim ]; };

    mine.xUserConfig = {

      xsession.windowManager.xmonad = {
        enable = true;
        extraPackages = self: [
          self.fuzzy
          config.mine.taffybar.package
          self.taffybar
        ];
        enableContribAndExtras = true;
        config = pkgs.runCommand "xmonad.hs" (config.scripts // {
          spacing = if config.mine.hardware.battery then "False" else "True";
        }) "substituteAll ${./xmonad.hs} $out";
      };
    };
  };
}
