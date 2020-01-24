{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./custom-hardware.nix

    ../../../config

    ../../../modules/development.nix

    # media
    ../../../modules/plex

    ../../../modules/jupyter
    
    ../../../modules/scrape.nix
    ../../../modules/virtualization/docker.nix
    #../../../modules/virtualization/virtualbox.nix

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

  mine.enableUser = true;
  mine.dev.hoogle.enable = true;
  mine.profiles.desktop.enable = true;
  mine.gaming.enable = true;
  mine.znc.enable = true;
  mine.nextcloud.enable = true;
  mine.deluged.enable = true;

  services.xserver.dpi = 80;
  networking.firewall.allowedTCPPorts = [ 3128 ];
  services.squid = {
    enable = true;
    extraConfig = ''
      acl pkgfile url_regex gs2.ww.prod.dl.playstation.net/gs2/appkgo/prod/CUSA01127_00/1/f_1818ed1e5995c6e5950f34b9c57faac61a2a63693828d6b9290e8c74e4b9d5cc/f/UP4511-CUSA01127_00-PPPPPPPPTTTTTTTT.json
      deny_info http://archive.org/download/studios/studios.json pkgfile

      http_reply_access deny pkgfile

      acl iconwall url_regex gs2.ww.prod.dl.playstation.net/gs2/appkgo/prod/CUSA01114_00/1/f_1a12093906541bc35b535b00d2b92966faf18f77e404548377e471f0f7aa8259/f/EP4511-CUSA01114_00-PPPPPPPPTTTTTTTT.json
      deny_info http://archive.org/download/yikes_201512/yikes.json iconwall
    '';
  };

  boot.initrd.checkJournalingFS = false;
  networking.hostName = "nixtoo";
  system.stateVersion = "19.09";
}
