{ config, pkgs, ... }:
{
  home-manager.users.evanjs = {
    qt = {
      enable = true;
      platformTheme = "gtk";
    };
  };
}
