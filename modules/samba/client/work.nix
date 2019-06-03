{ config, pkgs, ... }:
{
  imports = [
    ./default.nix
  ];

  environment.systemPackages = with pkgs; [
    kdeApplications.kdenetwork-filesharing
    kdeApplications.dolphin-plugins
    kdeFrameworks.kio
    kdeApplications.kio-extras
    dolphin
  ];

  services.samba = {
    configText = ''
        workgroup = RJGTECH.LOCAL
    '';
  };
}
