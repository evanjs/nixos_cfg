{ config, pkgs, ... }:
{
  home-manager.users.evanjs = {
    programs.zsh = {
      localVariables = {
        POWERLEVEL9K_MODE = "nerdfont-complete";
        POWERLEVEL10K_MODE = "nerdfont-complete";

        POWERLEVEL9K_LEFT_PROMPT_ELEMENTS = [
          "context"
          "dir"
          "vcs"
          ];

          POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS = [
            "status"
            "root_indicator"
            "background_jobs"
            "os_icon"
          ];
        };
      };
    };
  }
