{ config, pkgs, lib, programs, ... }:
with lib;
{
  options = {
    laststatus = 2;
  };
  config.programs.nixvim = {
    #extraPlugins = with pkgs.vimPlugins; [
      #vim-airline-themes
    #];
    plugins.airline = {
      enable = true;
      theme = "wombat";
      #powerlineFonts = true;
    };
  };
}
