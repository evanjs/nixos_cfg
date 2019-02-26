{ config, ... }:
{
  services = {
    postgresql = {
      enable = true;
      enableTCPIP = true;
    };
  };
}
