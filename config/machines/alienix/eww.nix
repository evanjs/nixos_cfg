{ config, lib, pkgs, inputs, ... }:
{
  home-manager.users.evanjs.programs.eww = {
  #mine.xUserConfig.programs.eww = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
