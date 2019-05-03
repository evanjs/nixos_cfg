{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    kdeApplications.kdenetwork-filesharing
    kdeApplications.dolphin-plugins
    kdeFrameworks.kio
    kdeApplications.kio-extras
    dolphin
  ];

  services.samba = {
    enable = false;
    configText = ''
        workgroup = RJGTECH.LOCAL
    '';
  };
}
