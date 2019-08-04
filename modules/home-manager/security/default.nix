{ config, pkgs, ... }:
{
  home-manager.users.evanjs = {
    home.packages = with pkgs; [
      pass
    ];
  };
}
