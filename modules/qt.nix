{ config, pkgs, ... }:
let
  qt5Pkgs = with pkgs.qt5; [
        # qt
        #full
        #full.dev
        qtbase
        qtbase.dev
        qtquickcontrols
        qtquickcontrols.dev
        qtquickcontrols2
        qtquickcontrols2.dev
        qtimageformats
        qttools
        qtdeclarative
        qtdeclarative.dev
      ];

in
  {
    environment = {
      systemPackages = with pkgs; [
        libsForQt5.qtstyleplugins
        qtcreator
        #rust-qt-binding-generator
      ]
      ++ qt5Pkgs
      ;

    };



  }

