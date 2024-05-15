{ config, pkgs, lib, programs, ... }:
with lib;
{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      vim-airline-themes
    ];
    options = {
      laststatus = 2;
    };
    plugins.airline = {
      enable = true;
      theme = "wombat";
      powerlineFonts = true;
    };
  };
}
