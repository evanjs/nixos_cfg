{ config, lib, pkgs, ... }:
{
  programs.zsh = {
    localVariables = {
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
}
