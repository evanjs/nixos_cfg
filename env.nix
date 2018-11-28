  { config, pkgs, ...}: 
  {
    environment.variables = {
      EDITOR                        = "nvim";
      VISUAL                        = "nvim";
      _JAVA_AWT_WM_NONREPARENTING   = "1";
    };
  }
