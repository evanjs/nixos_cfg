{ config, pkgs, ... }:
{
  home-manager.users.evanjs = {
    programs = {
      gpg = {
        enable = true;
      };
    };

    services = {
      gpg-agent = {
        enable = true;
        enableScDaemon = true;
        enableSshSupport = true;
      };
    };
  };
}
