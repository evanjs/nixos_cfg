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
    SupplementaryGroups = [ "docker" ];
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
      # data_dir = "/var/lib/vector";

      sources = {
        vector_internal_logs = {
          type = "internal_logs";
        };
        vector_internal_metrics = {
          type = "internal_metrics";
        };
      };
      sinks = {
        prometheus = {
          inputs = [
            "vector_internal_metrics"
          ];
        };
        file_vector_internal = {
          type = "file";
          path = "/tmp/log/vector/vector_internal-%Y-%m-%d.json";
          inputs = [
            "vector_internal_logs"
          ];
          encoding.codec = "text";
        };
        clickhouse_vector_internal = {
          type = "clickhouse";
          inputs = [
            "vector_internal_logs"
          ];
          endpoint = "http://localhost:8123";
          database = "logs";
          table = "vector_internal";
          skip_unknown_fields = true;
        };
      };
    };
  };

  # Journald Tweaks for Log Retention
  #services.journald.extraConfig = ''
  #SystemMaxUse=2000M
  #SystemKeepFree=1G
  #RuntimeMaxUse=512M
  #'';

}
