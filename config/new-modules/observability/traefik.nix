{
  config,
  pkgs,
  lib,
  ...
}:
{
  systemd.services.vector.serviceConfig = {
    SupplementaryGroups = [
      "traefik"
    ];
  };
  # Enable Traefik for reverse proxying and TLS certificates
  services.traefik = {
    enable = true;
    staticConfigOptions = {
      entryPoints = {
        web = {
          address = ":80";
        };
        websecure = {
          address = ":443";
        };
      };
      api = {
        insecure = true;
        dashboard = true;
        debug = true;
      };
      providers = {
        docker = {
          exposedByDefault = false;
        };
      };
      certificatesResolvers = {
        tailscale = {
          acme = {
            email = "evanjsx@gmail.com";
            storage = "/var/lib/traefik/acme.json";

            httpChallenge = {
              entrypoint = "web";
            };

            #dnsChallenge = {
              #provider = "tailscale"; # Replace with your DNS provider
              #delayBeforeCheck = 0;
              #resolvers = [
                #"1.1.1.1:53"
                #"1.0.0.1:53"
              #];
            #};
          };
        };
      };
    };
    dynamicConfigOptions = {
      ping = true;
      http = {
        middlewares = {
          httpsRedirect = {
            redirectScheme = {
              scheme = "https";
            };
          };
        };
      };
    };
  };
}
