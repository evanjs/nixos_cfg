{
  config,
  pkgs,
  lib,
  ...
}:
{
  mine.prometheus.server.enable = true;
  systemd.services.vector.serviceConfig = {
    SupplementaryGroups = [
      "prometheus"
    ];
  };

  services.grafana = {
    provision = {
      datasources.settings.datasources = [
        {
          name = "Prometheus";
          type = "prometheus";
          url = "http://localhost:9090";
        }
      ];
    };
  };

  # Enable Prometheus
  services.prometheus = {
    #enable = true;
    #webExternalUrl = "http://localhost:9090";
    scrapeConfigs = [
      {
        job_name = "vector";
        static_configs = [ { targets = [ "localhost:8686" ]; } ];
      }
    ];
  };

  services.traefik = {
    dynamicConfigOptions = {
      routers = {
        prometheus = {
          #middlewares = [
            #"httpsRedirect"
          #];
          rule = "Host(`${config.networking.hostName}-prometheus.takaya-boa.ts.net`)";
          service = "prometheus";
          entryPoints = [ "websecure" ];
          tls = {
            certResolver = "tailscale";
            domains = [
              "${config.networking.hostName}-prometheus.takaya-boa.ts.net"
            ];
          };
        };
      };

      services = {
        prometheus.loadBalancer.servers = [ { url = "http://localhost:9090"; } ];
      };
    };
  };

  services.vector.settings = {
    sinks = {
      prometheus = {
        #type = "prometheus_remote_write";
        type = "prometheus_exporter";
        inputs = [
          "host_metrics"
        ];
        #endpoint = "http://localhost:9090/api/v1/write";
      };
    };
  };

  # Open Firewall Ports
  networking.firewall.allowedTCPPorts = [
    8686
    9090
  ];
}
