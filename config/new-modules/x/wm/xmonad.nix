{ config, pkgs, lib, ... }:

with lib;

let

  weechat = pkgs.weechat.override { configure = { availablePlugins, ... }: {
    plugins = builtins.attrValues (availablePlugins // {
      python = availablePlugins.python.withPackages (ps: with ps; [ twitter ]);
    });
  };};

in

{

  imports = [
    ./files
  ];

  options = {
    mine.wm.enable = mkEnableOption "My window manager";
  };

  config = mkIf config.mine.wm.enable {

    mine.xmobar.enable = true;
    mine.taffybar.enable = false;
    mine.compton = {
      enable = true;
      highend = true;
    };
    mine.terminal.enable = true;

    services.weechat = {
      enable = true;
      binary = weechat;
    };
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
