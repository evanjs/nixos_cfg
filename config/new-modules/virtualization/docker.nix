{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.mine.virtualization.docker;
in
  {
    options.mine.virtualization.docker = {
      enable = mkEnableOption "Docker support";
    };

    config = mkIf cfg.enable {
      virtualisation = {
        docker = {
          enable = true;
          autoPrune.enable = true;
        };
      };
      users.users.evanjs.extraGroups = [ "docker" ];
    };
  }
