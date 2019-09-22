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
    extraConfig = ''
      local master = yes
      workgroup = RJGTECH.LOCAL
      ;client use spnego = no
      ;client ntlmv2 auth = no
    '';
  };


  fileSystems."/mnt/rjg/rjgfs1/engineering" = {
    device = "//RJGFS1/Engineering";
    fsType = "cifs";
    options = let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,ip=192.168.2.2";

    in ["${automount_opts},credentials=/etc/nixos/modules/samba/client/smb-secrets"];
  };
}

