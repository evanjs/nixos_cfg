{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Enable Grafana for Visualization
  services.grafana = {
    enable = true;
    settings.server.http_port = 3000;
    provision = {
      enable = true;
      dashboards.settings.providers = [
        {
          name = "default";
          options.path = "/var/lib/grafana/dashboards";
        }
      ];
    };
  };

  services.traefik = {
    dynamicConfigOptions = {
      routers = {
        grafana = {
          #middlewares = [
            #"httpsRedirect"
          #];
          rule = "Host(`${config.networking.hostName}-grafana.takaya-boa.ts.net`)";
          service = "grafana";
          entryPoints = [ "websecure" ];
          tls = {
            certResolver = "tailscale";
            domains = [
              "${config.networking.hostName}-grafana.takaya-boa.ts.net"
            ];
          };
        };
      };
      services = {
        grafana.loadBalancer.servers = [ { url = "http://localhost:3000"; } ];
      };
    };
  };

  # Open Firewall Ports
  networking.firewall.allowedTCPPorts = [
    3000
  ];
}
