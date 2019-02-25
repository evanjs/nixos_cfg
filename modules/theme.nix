{ config, pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [ breeze-gtk breeze-qt5 ] ++ [ qt5ct lxappearance ];
    shellInit = ''
        export GTK_PATH=$GTK_PATH:${pkgs.breeze-gtk}/share/themes/Breeze-Dark/gtk-2.0
        export GTK2_RC_FILES=${pkgs.breeze-gtk}/share/themes/Breeze-Dark/gtk-2.0/gtkrc
        export QT_QPA_PLATFORMTHEME=qt5ct
        export GTK_THEME=Breeze-Dark
    '';
  };
}
