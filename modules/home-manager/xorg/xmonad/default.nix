{ config, pkgs, lib, ... }:
let
  xorgPkgs = with pkgs.xorg; [
    libX11
    libXext
    libXinerama
    libXrandr
    libXrender
    libXft
  ];
in
  {
    imports = [
      ./files
    ];

    home-manager.users.evanjs = {
      xsession = {
        windowManager = {
          xmonad = {
            config = ./xmonad.hs;
            enable = true;
            enableContribAndExtras = true;
            extraPackages = hp: with pkgs; [
              gcc
              hicolor-icon-theme
              libxml2
              pkgconfig
              upower
              x11
              xmonad-log
            ]
            ++ xorgPkgs;

            haskellPackages = pkgs.haskell.packages.ghc865;
          };
        };
      };
    };
  }
