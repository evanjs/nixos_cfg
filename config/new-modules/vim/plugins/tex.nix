{ config, pkgs, lib, programs, ... }:
with lib;
let
  isTexEnabled = config.mine.tex.enable or false;
in
  mkIf isTexEnabled {
    programs.nixvim = {
      extraPlugins = with pkgs.vimPlugins; [
        latex-box
        vim-latex-live-preview
      ];

      globalOptions = {
        livepreview_previewer = "${pkgs.okular}/bin/okular";
      };

      plugins.vimtex = {
        enable = true;

        extraConfig = {
          log_verbose = 1;
        };
      };
    };
  }
