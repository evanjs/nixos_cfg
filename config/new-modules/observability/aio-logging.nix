{ config, pkgs, ... }:

let
  lib = pkgs.lib;
in
{
  mine.virtualization.docker.enable = true;

  systemd.services.vector.serviceConfig = {
    #Environment = ''
      #VECTOR_LOG="debug"
    #'';
    SupplementaryGroups = [
      "docker"
    ];
  };

  #users.groups.systemd-journal.members = [
  #"vector"
  #];

  # Enable Vector for OTLP, Journald, Host Metrics
  services.vector = {
    enable = true;
    settings = {
      api = {
        enabled = true;
      };
      data_dir = "/var/lib/vector";

    };
  };


  # Journald Tweaks for Log Retention
  #services.journald.extraConfig = ''
  #SystemMaxUse=2000M
  #SystemKeepFree=1G
  #RuntimeMaxUse=512M
  #'';

}

