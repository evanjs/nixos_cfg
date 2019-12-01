{ lib, config, pkgs, services, ... }:

with lib;

let

  cfg = config.mine.nextcloud;
in
  {
    options.mine.nextcloud = {
      enable = mkEnableOption "Nextcloud Configuration";
        openFirewall = mkOption {
          type = types.bool;
          default = true;
          example = false;
          description = "Open ports in the firewall for NextCloud.  This is required for remote access.";
        };
      };

    config = mkIf cfg.enable {
          services.nextcloud = {
            enable = true;
            autoUpdateApps.enable = true;
            caching.apcu = true;
            config = {
              adminpass = config.private.passwords.nextcloud;
              dbtype = "pgsql";
              extraTrustedDomains = [
                "10.10.0.*"
                "75.129.188.19"
                "http://a28209498ca7.sn.mynetname.net"
              ];
            };

        home = "/data/web/nextcloud";
            hostName = "nextcloud";

            nginx.enable = true;
          };
        services.phpfpm.pools.nextcloud.phpOptions = ''
            memcache.local = \OC\Memcache\APCu
            apc.enable_cli = 1
        '';
      environment.systemPackages = with pkgs; [
        p7zip
      ];
      };
    }
