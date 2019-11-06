{ pkgs, config, lib, ... }:
with lib;
let

  weechat = pkgs.weechat.override { configure = { availablePlugins, ... }: {
    plugins = builtins.attrValues (availablePlugins // {
      python = availablePlugins.python.withPackages (ps: with ps; [ twitter ]);
    });
  };};

in
  {
    imports = [
      ../../../modules/audio.nix
      ../../../modules/channels.nix
      ../../../modules/cloud-storage.nix
      ../../../modules/fonts.nix
      ../../../modules/fs.nix
      ../../../modules/games
      ../../../modules/home-manager
      ../../../modules/i18n/ibus.nix
      ../../../modules/iOS.nix
      ../../../modules/java.nix
      ../../../modules/media.nix
      ../../../modules/nixops.nix
      ../../../modules/notifications.nix
      ../../../modules/plymouth.nix
      ../../../modules/qt.nix
      ../../../modules/remote.nix
      ../../../modules/social
      ../../../modules/tex.nix
      ../../../modules/theme
      ../../../modules/web.nix
      ../../../modules/wine.nix
      ../../../modules/wireshark.nix
      ../../../modules/xrdp.nix
    ];

    options.mine.profiles.desktop = {
      enable = mkEnableOption "desktop config";
    };

    config = mkIf config.mine.profiles.desktop.enable {
      mine.emacs = {
        enable = true;

        config = {
          #haskell = true;
          doom = {
            modeline = true;
          };
          helm = true;
          jenkins = true;
          lsp = true;
          news = true;
          nix = true;
          rust = true;
          typescript = true;
          games = true;
        };
      };
      mine.vim.enable = true;
      /* mine.newsboat.enable = true; */

      mine.userConfig = {
      #services.gpg-agent = {
        #enable = true;
        #enableSshSupport = true;
      #};
    };

    boot.kernelPackages = pkgs.linuxPackages_latest;

    hardware.openrazer.enable = true;

    mine.deluged.enable = true;
    mine.x.enable = true;
    mine.wm.enable = true;
    mine.dev.haskell.enable = true;
    mine.dev.rust = {
      enable = true;
      plugins = [ "rust-std" "rust-src" ];
      channel = "beta";
      extraPackages = with pkgs; [ cargo-edit cargo-license cargo-asm cargo-outdated cargo-update cargo-bloat cargo-fuzz cargo-watch cargo-sweep stdenv.cc sccache pkgs.nixpkgs-unstable.evcxr chit diesel-cli ];
    };
    mine.jetbrains = {
      enable = true;
      useLatest = true;
    };

    mine.lorri = {
      enable = true;
      #logLevel = "lorri=info"; way too much going to the journal.  Can we still output but not to the journal?
    };

    environment.systemPackages = with pkgs; [
      # graphical admin tools
      filelight
      qdirstat
      wtf
      ncurses.dev # infocmp, etc
      gparted

      # git ui
      (pkgs.versions.latestVersion [pkgs.nixos-unstable.gitkraken pkgs.nixpkgs-unstable.gitkraken pkgs.stable.gitkraken])
      

      # media
      feh
      geeqie
      mplayer

      # browsers
      firefox

      # docs
      xpdf
      okular

      # word processors, etc
      pkgs.stable.libreoffice
      gnome3.gucharmap

      rrbg # background switcher
      speedtest-cli
      graphviz

      kitty
      stable.cachix
      xorg.xdpyinfo
    ];

    #services.usbmuxd.enable = true;

    #services.dbus.socketActivated = true;

    services.psd = {
      enable = true;
    };

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
   powerManagement.enable = true;

   programs.screen = {
     screenrc = ''
        # for weechat service support, etc
        multiuser on
        acladd normal_user

        # Enable mouse scrolling and scroll bar history scrolling
        termcapinfo xterm* ti@:te@
     '';
   };

   services.weechat = {
     enable = false;
     binary = "${weechat}/bin/weechat-headless";
   };

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
