{ config, pkgs, ... }:
{
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fontconfig = {
      ultimate = {
        enable = true;
      };
    };

    fonts = with pkgs; [
      carlito # calibri and etc so docx files don't look weirder than usual
      corefonts # more windows fonts
      
      dejavu_fonts
      fira-code
      font-awesome-ttf
      ipaexfont
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
