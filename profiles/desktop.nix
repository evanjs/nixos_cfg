{ config, pkgs, ... }:
{
  imports = [
    ./default.nix
    ../modules/audio.nix
    ../modules/custom-xsession
    ../modules/fonts.nix
    ../modules/fs.nix
    ../modules/ibus.nix
    ../modules/iOS.nix
    ../modules/java.nix
    ../modules/jetbrains.nix
    ../modules/media.nix
    ../modules/notifications.nix
    ../modules/plymouth.nix
    ../modules/remote.nix
    ../modules/samba.nix
    ../modules/social.nix
    ../modules/tex.nix
    ../modules/theme.nix
    ../modules/unstable.nix
    ../modules/web.nix
    ../modules/wireshark.nix
    ../modules/wine.nix
    ../modules/xrdp.nix
  ];


  environment.systemPackages = with pkgs; [
    # graphical admin tools
    filelight
    qdirstat
    wtf
    ncurses.dev # infocmp, etc

    # git ui
    gitkraken

    # media
    feh
    mplayer

    # browsers
    chromium
    firefox-beta-bin

    rrbg # background switcher 
  ];

  services.locate = {
    enable = true;
    extraFlags = [
      "--prunepaths=/mnt/gentoo"
    ];
  };

  boot.kernelModules = [ "i2c-dev" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Use libinput to handle the input devices
  services.xserver.libinput.enable = true;

  services.avahi.publish.workstation = true;

  services.printing.enable = true;

  # Misc power
  powerManagement.cpuFreqGovernor = "performance";
  services.upower.enable = true;
  powerManagement.enable = true;

    #
    # Firewall rules
    #
    networking.firewall = {
      allowedTCPPorts = [
        80
        8000
        8080
        # Health server
        8089
      ];
    };

    services.openssh = {
      forwardX11 = true;
    };

    services.fstrim.enable = true;
  }
