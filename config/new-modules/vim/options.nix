{ config, pkgs, lib, ... }:
{
  programs.nixvim = {

    clipboard = {
      # Use system clipboard
      register = "unnamedplus";

      # ??? - what does this do?
      # providers.wl-copy.enable = true;
    };

    options = {
      number = true; # Display the absolute line number of the current line
      #pastetoggle = "<F2>";
      backspace = "2";
      syntax = "on";
      tags = "tags";

      # have a fixed column in which the diagnostics will appear
      # this removes the jitter from incoming warnings/errors
      signcolumn = "yes";
    };
  };
}
