{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.mine.bash-insulter;
in
  {
    options.mine.bash-insulter = {
      enable = mkEnableOption "Bash Insulter";
      # TODO: option for adding more insults
    };

    config = mkIf cfg.enable {
      mine.userConfig = {
        programs =
          let
            initScript = "${pkgs.bash-insulter}/share/bash-insulter/bash.command-not-found";
          in
          {
            bash.initExtra = "source ${initScript}";
            zsh.initExtra = "source ${initScript}";
          };
        };
      };
    }
