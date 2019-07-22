{ config, pkgs, ... }:
{
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;

    fonts = with pkgs; [
      corefonts
      dejavu_fonts
      fira-code
      font-awesome-ttf
      inconsolata
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      roboto
      source-code-pro
      source-sans-pro
      source-serif-pro
    ];
  };
}
