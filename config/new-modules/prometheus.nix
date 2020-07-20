{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.mine.prometheus;
in
  {
    options.mine.prometheus = {
      server.enable = mkEnableOption "prometheus server";
      export.enable = mkEnableOption "various exporters for prometheus";
    };

    config = mkMerge [
      (mkIf (cfg.server.enable) {
        services.prometheus.enable = true;
        networking.firewall.allowedTCPPorts = [ 9090 ];
      })
      (mkIf (cfg.server.enable && cfg.export.enable) {
        services.prometheus = {
          exporters = {
            node = {
              enable = true;
              enabledCollectors = [
                "conntrack"
                "diskstats"
                "entropy"
                "filefd"
                "filesystem"
                "loadavg"
                "mdadm"
                "meminfo"
                "netdev"
                "netstat"
                "stat"
                "time"
                "vmstat"
                "systemd"
                "logind"
                "interrupts"
                "ksmd"
              ];
              openFirewall = true;
            };

            postgres = {
              enable = true;
              openFirewall = true;
            };
          };

          scrapeConfigs = [
            {
              job_name = "node";
              static_configs = [{
                targets = [ "127.0.0.1:9100" ];
                labels = { instance = config.networking.hostName; };
              }];
            }
            {
              job_name = "prometheus";
              static_configs = [{
                targets = [ "127.0.0.1:9090" ];
                labels = { instance = config.networking.hostName; };
              }];
            }
          ];
        };
      })
    ];
  }

