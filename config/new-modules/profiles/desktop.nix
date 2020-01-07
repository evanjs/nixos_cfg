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
      ../../../modules/cloud-storage.nix
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
      #../../../modules/virtualization/virtualbox.nix
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
          theme = {
            package = pkgs.emacsPackages.doom-themes;
            name = "doom-one";
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
        programs = {
          mpv = {
            enable = true;
            config = {
              interpolation="yes";
              video-sync = "display-resample";
              tscale = "oversample";
            };
            profiles = {
              fast = {
                vo = "vdpau";
              };
              svp = {
                input-ipc-server = "/tmp/mpvsocket";    # Receives input from SVP
                hr-seek-framedrop = "no";               # Fixes audio desync
                resume-playback = "no";                 # Not compatible with SVP
              };
            };
          };

        };

        gtk = {
          enable = true;
          theme = {
            name = "Breeze-Dark";
            package = pkgs.breeze-gtk;
          };
        };
        qt = {
          enable = true;
          platformTheme = "gtk";
        };
      };

      mine.vim = {
        colorscheme = "spacecamp";
        extraPlugins = with pkgs.vimPlugins; [ SpaceCamp ];
      };

      boot.kernelPackages = pkgs.linuxPackages_latest;
      boot.tmpOnTmpfs = true;

      hardware.openrazer.enable = true;

      mine.deluged.enable = true;
      mine.x.enable = true;
      mine.wm.enable = true;
      mine.dev.haskell.enable = true;
      mine.dev.rust = {
        enable = true;
        plugins = [ "rust-std" "rust-src" ];
        channel = "stable";
        extraPackages = with pkgs; [
          stable.cargo-edit
          cargo-license
          cargo-asm
          cargo-outdated
          cargo-update
          cargo-bloat
          cargo-fuzz
          cargo-watch
          cargo-sweep
          stdenv.cc
          sccache
          pkgs.nixpkgs-unstable.evcxr
          chit
          diesel-cli
        ];
      };
      mine.jetbrains = {
        enable = true;
        useLatest = true;
      };

      environment.systemPackages = with pkgs; [
      # graphical admin tools
      filelight
      stable.qdirstat
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
      tigervnc
      sshfs
    ];

    #services.dbus.socketActivated = true;

    services.gpm.enable = true;


    nixpkgs.config.packageOverrides = pkgs: {
      lorri = 
      let src = (import ../../sources).lorri;
      #in pkgs.lorri.overrideAttrs(attrs: { inherit src; } );
      in import src { inherit src; };
    };
    services.lorri.enable = true;

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

    boot.loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;

        efiSupport = true;
        # allow grub to work with no explicit boot device
        device = "nodev";
        useOSProber = true;
      };
    };

    #services.printing.enable = true;

    documentation = {
      dev.enable = true;
    };

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

   programs.thefuck.enable = true;

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
        5900 #vnc
        # Health server
        8089
      ];
    };

    services.fstrim.enable = true;
  };
}
