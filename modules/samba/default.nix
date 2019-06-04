{ config, ... }:
{
  services = {
    samba = {
      enable = true;
      #syncPasswordsByPam = true;
    };
  };

  systemd.services = {
    samba-smbd = {
      serviceConfig = {
        #LogLevelMax = 4;
      };
    };
    samba-nmbd = {
      serviceConfig = {
        #LogLevelMax = 4;
      };
    };
    samba-winbindd = {
      serviceConfig = {
        #LogLevelMax = 4;
      };
    };
  };

  networking.firewall = {
    allowPing = true;
    allowedTCPPorts = [ 445 139 ];
    allowedUDPPorts = [ 137 138 ];
  };
}
