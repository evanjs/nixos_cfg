{ pkgs, config, lib, ... }:
with lib;
{
  options.mine.profiles.desktop = {
    enable = mkEnableOption "desktop config";
  };

  config = mkIf config.mine.profiles.desktop.enable {
    mine.vim.enable = true;
    /* mine.newsboat.enable = true; */

    mine.userConfig = {
      #services.gpg-agent = {
        #enable = true;
        #enableSshSupport = true;
      #};
    };

    mine.x.enable = true;
    mine.wm.enable = true;
    /* mine.dev.haskell.enable = true; */
    mine.dev.rust = {
      enable = true;
      plugins = [ "rust-std" "rust-src"];
      channel = "nightly";
    };
    mine.jetbrains.enable = true;

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
      geeqie
      mplayer

      # browsers
      (versions.atLeastVersion "67.0" [firefox firefox-beta-bin])

      # word processors, etc
      pkgs.stable.libreoffice
      gnome3.gucharmap

      rrbg # background switcher
      speedtest-cli
      graphviz

      kitty
      cachix
    ];

    #services.usbmuxd.enable = true;

    #services.dbus.socketActivated = true;

    boot.supportedFilesystems = [ "exfat" "ntfs" "f2fs" "btrfs" ];

    #services.locate = {
      #enable = true;
      #extraFlags = [
        #"--prunepaths=/mnt/gentoo"
      #];
    #};

    boot.kernelModules = [ "i2c-dev" ];

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    #services.printing.enable = true;

   # Misc power
   powerManagement.cpuFreqGovernor = "performance";
   #services.upower.enable = true;
   powerManagement.enable = true;

   #services.openssh = {
     #enable = true;
     #forwardX11 = true;
   #};

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

      #services.fstrim.enable = true;


    };
  }
