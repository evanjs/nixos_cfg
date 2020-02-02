{ config, pkgs, lib, ... }:

with lib;

let
  hpkgs = pkgs.stable.haskell.packages.ghc865.override {
    overrides = new: old: rec {
      xmonad-contrib = old.xmonad-contrib.overrideAttrs (oldAttrs: rec {
        patches = [
          (pkgs.fetchpatch {
            # add promptSearchBrowser' from https://github.com/xmonad/xmonad-contrib/pull/330
            name = "promptSearchBrowser.patch";
            url =
              "https://github.com/xmonad/xmonad-contrib/commit/5493ff190d0d5e207dde07139fd371f8057d9e93.diff";
              sha256 = "1c2ay8f9bxc4fwccsga0mvpdlrv4l31ildwvirn6lvph5y5kpxfb";
            })
          ];
        });
      };
    };
in {
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

    scripts = 
    let
      maim = "${pkgs.maim}/bin/maim";
      xclip = "${pkgs.xclip}/bin/clip";
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
      selectScreenshotCmd = "${maim} -s ~/shots/$(date ${screenshotDateFormat}).png";
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
          taffybar
        ];
        haskellPackages = hpkgs;

        enableContribAndExtras = true;
        config = pkgs.runCommand "xmonad.hs" (config.scripts // {
          spacing = if config.mine.hardware.battery then "False" else "True";
        }) "substituteAll ${./xmonad.hs} $out";
      };
    };
  };
}
