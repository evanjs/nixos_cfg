{ config, pkgs, ... }:
{
  services = {

    pgmanage = {
      enable = true;
    };

    postgresql = {
      enable = true;
      enableTCPIP = true;
      package = pkgs.postgresql_10;
    };
  };
}
