{ config, pkgs, lib, ... }:
{
  imports = [
    ./xmonad
  ];

  home-manager.users.evanjs = {
    home.packages = with pkgs; [
      arandr
      haskellPackages.xmobar
      maim
      rofi
      trayer
      xclip
      xdotool
      xlockmore
      xorg.xbacklight
      xscreensaver
      xtrlock-pam
    ];
    xsession = {
      enable = true;
      numlock.enable = true;
      pointerCursor = {
        name = "breeze_cursors";
        size = 16;
        package = pkgs.plasma5.breeze-qt5;
      };
    };
  };
}
