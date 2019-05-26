{ config, pkgs, ... }:
{
  imports = [
    ./default.nix
    ../modules/audio.nix
    ../modules/chromium.nix
    ../modules/custom-xsession
    ../modules/fonts.nix
    ../modules/fs.nix
    ../modules/ibus.nix
    ../modules/iOS.nix
    ../modules/java.nix
    ../modules/jetbrains.nix
    ../modules/media.nix
    ../modules/nixops.nix
    ../modules/notifications.nix
    ../modules/plymouth.nix
    ../modules/qt.nix
    ../modules/remote.nix
    ../modules/social.nix
    ../modules/tex.nix
    ../modules/theme
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
    gparted

    # git ui
    gitkraken

    # media
    feh
    mplayer

    # browsers
    firefox-beta-bin

    # word processors, etc
    libreoffice

    rrbg # background switcher 
    speedtest-cli
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
