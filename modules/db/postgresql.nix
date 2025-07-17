{ config, pkgs, ... }:
{
  networking.firewall.allowedTCPPorts = [ 5432 ];

  services = {

    pgmanage = {
      enable = true;
      port = 8099;
    };

    postgresql = {
      authentication = pkgs.lib.mkOverride 11 ''
        local   all             all                                     ident
        local   all             all                                     trust
        host    all             all             127.0.0.1/32            trust
        host    all             all             ::1/128                 trust
        local   replication     all                                     trust
        host    replication     all             127.0.0.1/32            trust
        host    replication     all             ::1/128                 trust
        host    all             all             10.10.0.1/16            trust
      '';

      initialScript = pkgs.writeText "backend-initScript" ''
        CREATE DB copilot
      '';

      enable = true;
      enableTCPIP = true;
      package = pkgs.postgresql_11;
    };
  };
}
