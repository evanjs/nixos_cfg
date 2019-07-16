{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    powerline-go
  ];

  programs.bash.initExtra = ''
    function _update_ps1() {
    PS1="$(${pkgs.powerline-go}/bin/powerline-go -error $?)"
    }

    if [ "$TERM" != "linux" ] && [ -f "${pkgs.powerline-go}/bin/powerline-go" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
    fi
  '';
}
