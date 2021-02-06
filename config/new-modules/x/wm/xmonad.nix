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
    mine.terminal.enable = true;

    scripts = 
    let
      maim = "${pkgs.maim}/bin/maim";
      xclip = "${pkgs.xclip}/bin/xclip";
      zeal = "${pkgs.zeal}/bin/zeal";
      xdotool = "${pkgs.xdotool}/bin/xdotool";
      screenshotDateFormat = "+%Y-%m-%d_%T";
    in
    {
      emacs = ''
        if ! [ $(systemctl --user is-active emacs) = active ]; then
        systemctl --user start emacs
        fi
        emacsclient -c -n
      '';
      terminal = "kitty";
      xmobar = config.mine.xmobar.command;
      clipboardScreenshotCmd = "${maim} -i $(${xdotool} getactivewindow) | ${xclip} -selection clipboard -t image/png";
      selectScreenshotCmd = "${maim} --hidecursor -s ~/shots/$(date ${screenshotDateFormat}).png";
      screenshotCmd = "${maim} > ~/shots/$(date ${screenshotDateFormat}).png";
      delayedScreenshotCmd = "${maim} -d3 ~/shots/$(date ${screenshotDateFormat}).png";
      activeWindowScreenshotCmd = "${maim} -i $(${xdotool} getactivewindow) > ~/shots/$(date ${screenshotDateFormat}).png";
      xftFont = "xft:${config.mine.font.name}";
    };

    mine.userConfig = { home.packages = [ pkgs.maim ]; };

    mine.xUserConfig = {

      xsession.windowManager.xmonad = {
        enable = true;
        extraPackages = self: with self; [
          fuzzy
        ] ++ optionals config.mine.taffybar.enable [
          config.mine.taffybar.package
        ];

        enableContribAndExtras = true;
        config = pkgs.runCommand "xmonad.hs" (config.scripts // {
          spacing = if config.mine.hardware.battery then "False" else "True";
        }) "substituteAll ${./xmonad.hs} $out";
      };
    };
  };
}
