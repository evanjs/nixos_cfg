{ config, pkgs, ... }:
let
  credentials = "credentials=${config.private.passwords.samba.work.filename}";
in
{
  imports = [
    ./default.nix
  ];

  environment.systemPackages = with pkgs; [
    dolphin
  ] ++ (with plasma5Packages; [
    kdenetwork-filesharing
    dolphin-plugins
    kio
    kio-extras
  ]);

  services.samba = {
    settings = {
      local = {
        workgroup = "RJGTECH.LOCAL";
        master = true;
      };
    };
    #settings = ''
      #local master = yes
      #workgroup = RJGTECH.LOCAL
      #;client use spnego = no
      #;client ntlmv2 auth = no
    #'';
  };


  fileSystems."/mnt/rjg/rjgfs1/engineering" = {
    device = "//RJGFS1/Engineering";
    fsType = "cifs";
    options = let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,ip=192.168.2.2";

    in ["${automount_opts},${credentials}"];
  };
  fileSystems."/mnt/rjg/rjgtc2/products" = {
    device = "//RJGTC2/Products";
    fsType = "cifs";
    options = let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,ip=192.168.2.2";

    in ["${automount_opts},${credentials}"];
  };
  #fileSystems."/mnt/rjg/rjgtc2/customer_support" = {
    #device = "//RJGTC2/CustomerSupport";
    #fsType = "cifs";
    #options = let
        ## this line prevents hanging on network split
        #automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,ip=192.168.2.2";

    #in ["${automount_opts},${credentials}"];
  #};
  fileSystems."/mnt/rjg/rjgsource/copilot_releases" = {
    device = "//RJGSOURCE/copilot_releases";
    fsType = "cifs";
    options = let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,ip=192.168.2.193";

    in ["${automount_opts},${credentials}"];
  };
  fileSystems."/mnt/rjg/rjgsource/hub_releases" = {
    device = "//RJGSOURCE/hub_releases";
    fsType = "cifs";
    options = let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,ip=192.168.2.193";

    in ["${automount_opts},${credentials}"];
  };
}

