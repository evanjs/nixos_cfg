{ config, pkgs, lib, ... }:
{
  home-manager.users.evanjs = {
    home.packages = with pkgs; [
      powerline-go
    ];

    # TODO: Can this be disabled for nix-shells?
    # `set -x` makes nix-shells difficult to use when using powerline
    programs.bash.initExtra = ''
      function _update_ps1() {
      PS1="$(${pkgs.powerline-go}/bin/powerline-go -error $?)"
      }

      if [ "$TERM" != "linux" ] && [ -f "${pkgs.powerline-go}/bin/powerline-go" ]; then
      PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
      fi
    '';
  };
}
