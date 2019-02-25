{ config, pkgs, ... }:
{
  imports = [
    ./default.nix
    ../modules/audio.nix
    ../modules/custom-xsession
    ../modules/fonts.nix
    ../modules/ibus.nix
    ../modules/iOS.nix
    ../modules/java.nix
    ../modules/jetbrains.nix
    ../modules/media.nix
    ../modules/notifications.nix
    ../modules/remote.nix
    ../modules/samba.nix
    ../modules/social.nix
    ../modules/theme.nix
  ];


  environment.systemPackages = with pkgs; [
    # graphical admin tools
    filelight
    qdirstat

    # git ui
    gitkraken

    # media
    feh
    mplayer

    # browsers
    chromium
    firefox

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

    services.fstrim.enable = true;
  }