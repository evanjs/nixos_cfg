{ config, pkgs, lib, programs, ... }:
with lib;
{
  programs.nixvim = {
    plugins.tagbar = {
      enable = true;
      extraConfig = {
        # Width of the Tagbar window in characters
        width = 80;

        # Width of the Tagbar window when zoomed
        # Use the width of the longest currently visible tag
        tagbar_zoomwidth = 0;
      };
    };

    keymaps = [
      {
        key = "<F8>";
        action = ":TagbarToggle<CR>";
        options.silent = true;
      }
    ];
  };
}
