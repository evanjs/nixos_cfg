{ config, ... }:
{
  users.users.evanjs.extraGroups = [ config.users.users.deluge.group ];

  services.deluge = rec {
    enable = true;
    openFilesLimit = 8192;
    web = {
      enable = true;
      openFirewall = true;
    };
  };
}
