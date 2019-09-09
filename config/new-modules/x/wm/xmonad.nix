{ config, pkgs, lib, ... }:

with lib;

{

  imports = [
    ./files
  ];

  options = {
    mine.wm.enable = mkEnableOption "My window manager";
  };

  config = mkIf config.mine.wm.enable {

    services.xserver.windowManager.xmonad.enable = true;

    mine.xmobar.enable = true;
    mine.taffybar.enable = false;
    mine.compton = {
      enable = true;
      highend = true;
    };
    mine.terminal.enable = true;

    mine.userConfig = {
      home.packages = [ pkgs.maim ];
    };

    mine.xUserConfig = {

      xsession.windowManager.xmonad = {
        enable = true;
        extraPackages = self: [ self.fuzzy ];
        enableContribAndExtras = true;
        config = pkgs.runCommand "xmonad.hs" (config.scripts // {
          spacing = if config.mine.hardware.battery then "False" else "True";
        }) "substituteAll ${./xmonad.hs} $out";

      };
    };
  };
}
