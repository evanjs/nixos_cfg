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
        description =
          "Open ports in the firewall for NextCloud.  This is required for remote access.";
          };
          aria2.enable = mkEnableOption "Aria2 background server";
        };

        config = mkMerge [
          (
            {
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

                    nginx.enable = true;
                    package = pkgs.nextcloud18;
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

      (
        (mkIf (cfg.enable && cfg.aria2.enable)) {
          services.aria2 = {
            enable = true;
            openPorts = true;
            extraArguments = "--rpc-allow-origin-all -c -D --check-certificate=false --save-session-interval=2 --continue=true --rpc-save-upload-metadata=true --force-save=true --log-level=warn --rpc-listen-all=false";
          };

          users.users.nextcloud.extraGroups = [ "aria2" ];
        }
        )
      ];
    }
