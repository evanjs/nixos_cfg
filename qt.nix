{ config, pkgs, ... }:
let
  qt5Pkgs = with pkgs.qt5; [
        # qt
        #full.dev
        qtbase
        qtquickcontrols
        qtquickcontrols2
        qtimageformats
        qttools
      ];

in
  {
    environment = {
      systemPackages = with pkgs; [
        libsForQt5.qtstyleplugins
        qtcreator
      ]
      ++ qt5Pkgs
      ;

    };



  }

