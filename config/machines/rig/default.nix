{ config, pkgs, lib, ... }:
let
  keyFile = ./nix-binary-key;
in
{
  imports = [
    ./hardware-configuration.nix
    ./custom-hardware.nix

    ../../../config

    ../../../modules/development.nix

    # media
    ../../../modules/plex

    ../../../modules/jupyter

    ../../../modules/virtualization/docker.nix

    ../../../modules/samba/server/home.nix
  ];

  mine.hardware = {
    battery = false;
    cpuCount = 8;
    swap = false;
    touchpad = false;
    wlan = true;
    audio = true;
  };

  services.nix-serve = {
    enable = true;
    secretKeyFile = "${keyFile}";
    port = 8080;
  };

  programs.ssh.forwardX11 = true;
  programs.nh = {
    enable = true;
  };
  services.openssh.forwardX11 = true;

  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;

  nix.distributedBuilds = true;
  mine.android.enable = false;
  mine.enableUser = true;
  mine.profiles.desktop.enable = true;
  mine.gaming.enable = false;
  mine.znc.enable = false;
  mine.nextcloud = {
    aria2.enable = true;
    enable = false;
  };
  mine.emacs.enable = false;
  mine.taffybar.enable = false;
  mine.deluged.enable = true;
  mine.jetbrains.enable = false;

  mine.prometheus.server.enable = true;

  mine.fonts.bar.size.small = 10;
  mine.virtualization.virtualbox.enable = false;
  boot.kernelPackages = lib.mkForce pkgs.stable.linuxPackages;
  services.openssh.passwordAuthentication = false;
  #programs.hydrus.enable = true;

  services.caddy = {
    enable = true;
    config = ''
      https://evanjs.ddnsfree.com/
      reverse_proxy 10.10.0.184:45869
    '';
  };

  services.xserver.dpi = 80;
  networking.firewall.allowedTCPPorts = [ 3128 3000 ];
  services.squid = {
    enable = false;
    extraConfig = ''
      acl pkgfile url_regex gs2.ww.prod.dl.playstation.net/gs2/appkgo/prod/CUSA01127_00/1/f_1818ed1e5995c6e5950f34b9c57faac61a2a63693828d6b9290e8c74e4b9d5cc/f/UP4511-CUSA01127_00-PPPPPPPPTTTTTTTT.json
      deny_info http://archive.org/download/studios/studios.json pkgfile

      http_reply_access deny pkgfile

      acl iconwall url_regex gs2.ww.prod.dl.playstation.net/gs2/appkgo/prod/CUSA01114_00/1/f_1a12093906541bc35b535b00d2b92966faf18f77e404548377e471f0f7aa8259/f/EP4511-CUSA01114_00-PPPPPPPPTTTTTTTT.json
      deny_info http://archive.org/download/yikes_201512/yikes.json iconwall
    '';
  };

  users.users.evanjs.extraGroups = [ "cdrom" ];

  boot.extraModulePackages = [
    # insecure
    # config.boot.kernelPackages.broadcom_sta
  ];
  boot.initrd.checkJournalingFS = false;
  networking.hostName = "nixtoo";
  system.stateVersion = "19.09";
}
