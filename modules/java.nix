{ config, pkgs, ... }:
{
  environment.variables = {
    _JAVA_AWT_WM_NONREPARENTING   = "1";
  };

  programs.java = {
    enable = true;
  };
}
