{ config, ... }:
{
  home-manager.users.evanjs = {
    programs = {
      tmux = {
        enable = true;

        clock24 = true;

        keyMode = "vi";

        terminal = "screen-256color";

        tmuxinator = {
          enable = true;
        };
        newSession = true;
      };
    };
  };
}
