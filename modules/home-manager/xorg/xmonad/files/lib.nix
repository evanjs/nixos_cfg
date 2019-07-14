{ config, pkgs, lib, ... }:
let
  xmonadDir = ".xmonad";
in
  {
    home.file = {
      # Layout
      "FocusWindow" = {
        source = ../XMonadLayouts/FocusWindow.hs;
        target =  "${xmonadDir}/lib/XMonad/Layout/FocusWindow.hs";
      };

      "MasterOverlay" = {
        source = ../XMonadMasterOverlay/MasterOverlay.hs;
        target = "${xmonadDir}/lib/XMonad/Layout/MasterOverlay.hs";
      };

      "MiddleColumn" = {
        source = ../XMonadLayouts/MiddleColumn.hs;
        target =  "${xmonadDir}/lib/XMonad/Layout/MiddleColumn.hs";
      };

      "WindowColumn" = {
        source = ../XMonadLayouts/WindowColumn.hs;
        target =  "${xmonadDir}/lib/XMonad/Layout/WindowColumn.hs";
      };


      # Util
      "FileLogger" = {
        source = ../XMonadLayouts/FileLogger.hs;
        target =  "${xmonadDir}/lib/XMonad/Util/FileLogger.hs";
      };

      "WindowFinder" = {
        source = ../XMonadLayouts/WindowFinder.hs;
        target =  "${xmonadDir}/lib/XMonad/Util/WindowFinder.hs";
      };
    };
  }
