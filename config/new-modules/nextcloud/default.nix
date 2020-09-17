{ lib, config, pkgs, services, ... }:

with lib;
let
  cfg = config.mine.nextcloud;
  prometheus = config.services.prometheus.exporters.nextcloud;
in
{
  options.mine.nextcloud = {
    enable = mkEnableOption "Nextcloud Configuration";
    openFirewall = mkOption {
      type = types.bool;
      default = true;
      example = false;
      description =
        "Open ports in the firewall for NextCloud.  This is required for remote access.";
    };
    aria2.enable = mkEnableOption "Aria2 background server";
  };

  config = mkMerge [
    (
      mkIf cfg.enable {
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
          maxUploadSize = "8192M";

          package = pkgs.nextcloud19;
        };
        services.nginx = {
          recommendedOptimisation = true;
          recommendedGzipSettings = true;
          recommendedTlsSettings = true;
          recommendedProxySettings = true;
        };
        services.phpfpm.pools.nextcloud.phpOptions = ''
          memcache.local = \OC\Memcache\APCu
          apc.enable_cli = 1
        '';

        # https://github.com/NixOS/nixpkgs/pull/86417
        # What are the implications of this removal?
        # Will the [Extract](https://github.com/PaulLereverend/NextcloudExtract) plugin do anything about this?
        # TODO: can p7zip be made available exclusively from nextcloud's PATH, etc?
        nixpkgs.config.permittedInsecurePackages = [ "p7zip-16.02" ];
        environment.systemPackages = with pkgs; [ p7zip unrar ];
      }
    )

    ((mkIf (cfg.enable && cfg.aria2.enable)) {
      services.aria2 = {
        enable = true;
        openPorts = true;
        extraArguments = "--rpc-allow-origin-all -c -D --check-certificate=false --save-session-interval=2 --continue=true --rpc-save-upload-metadata=true --force-save=true --log-level=warn --rpc-listen-all=false";
      };

      users.users.nextcloud.extraGroups = [ "aria2" ];
    })
    ((mkIf (cfg.enable && config.mine.prometheus.export.enable))
      {

        services.prometheus = {
          scrapeConfigs = [
            {
              job_name = "nextcloud";
              static_configs = [{
                targets = [ "localhost:${toString prometheus.port}" ];
                labels = { instance = config.networking.hostName; };
              }];
            }
          ];
          exporters.nextcloud = {
            enable = true;
            openFirewall = true;
            passwordFile = ./password;
            username = "prometheus";
            url = "localhost";
          };
        };
      })
  ];
}
