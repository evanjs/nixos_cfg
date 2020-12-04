{ pkgs, config, lib, ... }:
with lib;
let

  weechat = pkgs.weechat.override {
    configure = { availablePlugins, ... }: {
      plugins = builtins.attrValues (availablePlugins // {
        python =
          availablePlugins.python.withPackages (ps: with ps; [ twitter ]);
      });
    };
  };

in {
  imports = [
    ../../../modules/audio.nix
    ../../../modules/cloud-storage.nix
    ../../../modules/fs.nix
    ../../../modules/games
    ../../../modules/i18n/ibus.nix
    ../../../modules/iOS.nix
    ../../../modules/java.nix
    ../../../modules/media.nix
    ../../../modules/nixops.nix
    ../../../modules/notifications.nix
    ../../../modules/plymouth.nix
    #../../../modules/qt.nix
    ../../../modules/remote.nix
    ../../../modules/social
    ../../../modules/web.nix
    ../../../modules/wine.nix
    ../../../modules/wireshark.nix
    ../../../modules/xrdp.nix
  ];

  options.mine.profiles.desktop = { enable = mkEnableOption "desktop config"; };

  config = mkMerge [
    /* If NIXOS_LITE=1, disable several heavier components to allow for rebuilds (for temporary profiles)
       on systems with limited storage space

       We can then run `nix-collect-garbage -d` and rebuild without this option
       to (hopefully) successfully install the remaining components
    */
    (mkIf ((maybeEnv "NOBRAINZ" "0") != "0") {
      mine.jetbrains.enable = mkForce false;
    })
    (mkIf ((maybeEnv "NOFONTZ" "0") != "0") {
      fonts.fonts = mkForce [ config.mine.font.package ];
    })
    (mkIf ((maybeEnv "NIXOS_LITE" "0") != "0") {
      mine = {
        jetbrains.enable = mkForce false;
        x.enable = mkForce false;
        wm.enable = mkForce false;
        emacs.enable = mkForce false;
        dev = {
          haskell.enable = mkForce false;
          rust.enable = mkForce false;
        };
        vim.enable = mkForce false;
        tex.enable = mkForce false;
      };

      #fonts.fonts = mkForce (lib.lists.filter (a: isDerivation a && (lib.strings.getName a) != "nerdfonts")  super.fonts.fonts);
      fonts.fonts = mkForce [ config.mine.font.package ];

      virtualisation = { virtualbox.host.enable = mkForce false; };

    })
    (mkIf config.mine.profiles.desktop.enable {
      mine.emacs = {
        enable = true;

        config = {
          haskell = true;
          doom = { modeline = true; };
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
      programs.vim.defaultEditor = true;

      # mine.newsboat.enable = true;

      programs.fuse.userAllowOther = true;

      services.geoclue2.enable = true;
      mine.userConfig = {
        programs = {
          mpv = {
            enable = true;
            config = {
              interpolation = "yes";
              video-sync = "display-resample";
              tscale = "oversample";
            };
            profiles = {
              fast = { vo = "vdpau"; };
              svp = {
                input-ipc-server = "/tmp/mpvsocket"; # Receives input from SVP
                hr-seek-framedrop = "no"; # Fixes audio desync
                resume-playback = "no"; # Not compatible with SVP
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

      mine.x.enable = true;
      mine.wm.enable = true;
      mine.dev.haskell = {
        enable = true;
        hoogle.enable = true;
      };
      mine.dev.rust = {
        enable = true;
        plugins = [ "rust-std" "rust-src" ];
        channel = "stable";
        extraPackages = with pkgs; [
          cargo-about
          cargo-edit
          cargo-license
          cargo-asm
          cargo-outdated
          stable.cargo-update
          cargo-bloat
          #cargo-fuzz
          cargo-watch
          cargo-sweep
          cargo-udeps
          stdenv.cc
          sccache
          evcxr
          chit
          diesel-cli
          silicon
          cargo-geiger
        ];
      };
      mine.jetbrains = {
        enable = true;
        useLatest = true;
      };

      environment.homeBinInPath = true;
      environment.systemPackages = with pkgs; [
        # graphical admin tools
        filelight
        qdirstat
        wtf
        ncurses.dev # infocmp, etc
        gparted

        # git ui
        (pkgs.versions.latestVersion [
          pkgs.nixos-unstable.gitkraken
          pkgs.nixpkgs-unstable.gitkraken
          pkgs.gitkraken
        ])

        # media
        feh
        geeqie
        mplayer

        # TODO: cuda support (nvenc, nvdec, etc.)
        ffmpeg-full

        # browsers
        firefox

        # docs

        # xpdf -- currently marked as insecure, with several known vulnerabilities
        # https://github.com/NixOS/nixpkgs/pull/68616
        # these issues will be fixed with the release of 5.0

        okular

        # word processors, etc
        pkgs.libreoffice
        gnome3.gucharmap

        speedtest-cli
        graphviz

        kitty
        cachix
        xorg.xdpyinfo
        stable.tigervnc
        sshfs

        # iOS stuff
        ideviceinstaller
        ifuse
        libimobiledevice

        # security
        veracrypt

        # editors
        atom

        rclone

        ghidra-bin

        _1password-gui
      ];

      #services.dbus.socketActivated = true;

      services.gpm.enable = true;

      services.lorri =
        let
          lorri = (import ../../nix/sources.nix {}).lorri;
        in
        {
          enable = true;
          #package = lorri;
      };

      services.psd = { enable = true; };

      boot.supportedFilesystems = [ "exfat" "ntfs" "f2fs" "btrfs" "nfs" ];

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

      documentation = { dev.enable = true; };

      # Misc power
      powerManagement.cpuFreqGovernor = lib.mkForce "performance";
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
          5900 # vnc
          # Health server
          8089
        ];
      };

      mine.virtualization = {
        docker.enable = true;
        libvirtd.enable = false;
      };

      # dmd is currently broken
      mine.onedrive.enable = false;

      services.fstrim.enable = true;

      mine.prometheus.export.enable = true;

      # what requires cryptography for python 2.7?
      nixpkgs.config.permittedInsecurePackages = [
        "python2.7-cryptography-2.9.2"
      ];
    })
  ];
}
