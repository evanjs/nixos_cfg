  { config, pkgs, ... }:
  {
    programs.bash = {
      interactiveShellInit = ''
        source ${pkgs.autojump}/share/autojump/autojump.bash
      '';
    };
  }
