{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Enable Grafana for Visualization
  services.grafana = {
    provision = {
      datasources.settings.datasources = [
        {
          name = "Loki";
          type = "loki";
          url = "http://localhost:3100";
        }
      ];
    };
  };

  # Enable Loki for Log Storage
  services.loki = {
    enable = true;
    configFile = ./loki-local-config.yaml;
    #configuration = {
      #auth_enabled = false;
      #server.http_listen_port = 3100;
      #limits_config.allow_structured_metadata = true;
      #schema_config.configs = [
        #{
          #from = "2024-01-01";
          #store = "boltdb-shipper";
          #object_store = "filesystem";
          #schema = "v13";
          #index = {
            #prefix = "index_";
            #period = "24h";
          #};
        #}
      #];
    #};
  };

  services.traefik = {
    dynamicConfigOptions = {
      http = {
        routers = {
          loki = {
            rule = "Host(`${config.networking.hostName}-loki.takaya-boa.ts.net`)";
            service = "loki";
            entryPoints = [ "websecure" ];
            tls = {
              certResolver = "tailscale"; # Reference the certificate resolver here
            };
          };
        };
        services = {
          loki.loadBalancer.servers = [ { url = "http://localhost:3100"; } ];
        };
      };
    };
  };

  services.vector.settings = {
    sinks = {
      loki = {
        type = "loki";
        inputs = [
          #"otlp"
          "journald"
        ];
        endpoint = "http://localhost:3100";
        encoding.codec = "json";
        labels = {
          job = "vector";
          host = "{{ host }}";
        };
      };

    };
  };

  # Open Firewall Ports
  networking.firewall.allowedTCPPorts = [ 3100 ];

}
