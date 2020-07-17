{ config, pkgs, ... }:
let
  credentials = "credentials=${config.private.passwords.samba.work.filename}";
in
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

    in ["${automount_opts},${credentials}"];
  };
  fileSystems."/mnt/rjg/rjgfs2/products" = {
    device = "//RJGFS2/Products";
    fsType = "cifs";
    options = let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,ip=192.168.2.2";

    in ["${automount_opts},${credentials}"];
  };
  fileSystems."/mnt/rjg/rjgfs2/customer_support" = {
    device = "//RJGFS2/CustomerSupport";
    fsType = "cifs";
    options = let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,ip=192.168.2.2";

    in ["${automount_opts},${credentials}"];
  };
}

