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
    ../../../modules/notifications.nix
    ../../../modules/plymouth.nix
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
    (mkIf ((maybeEnv "BRAINZ" "0") != "0") {
      mine.jetbrains.enable = true;
    })
    (mkIf ((maybeEnv "NOFONTZ" "0") != "0") {
      fonts.fonts = mkForce [ ];
    })
    (mkIf ((maybeEnv "NIXOS_LITE" "0") != "0") {
      mine = {
        jetbrains.enable = false;
        x.enable = false;
        wm.enable = false;
        emacs.enable = false;
        dev = {
          haskell.enable = false;
          rust.enable = false;
        };
        vim.enable = false;
        tex.enable = false;
	      firefox.enable = false;
      };

      #fonts.fonts = mkForce (lib.lists.filter (a: isDerivation a && (lib.strings.getName a) != "nerdfonts")  super.fonts.fonts);
      fonts.fonts = mkForce [ config.mine.fonts.mainFont.package ];

      virtualisation = { virtualbox.host.enable = mkForce false; };

    })
    (mkIf config.mine.profiles.desktop.enable {

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
          enable = lib.mkDefault true;
          theme = {
            name = "Breeze-Dark";
            package = pkgs.breeze-gtk;
          };
        };
        qt = {
          enable = lib.mkDefault true;
          platformTheme = "gtk";
        };
      };


      boot.kernelPackages = pkgs.stable.linuxPackages_latest;
      boot.tmpOnTmpfs = true;

      hardware.openrazer = {
        enable = true;
        users = [
          "evanjs"
        ];
      };

      mine.x.enable = lib.mkDefault true;
      mine.wm.enable = lib.mkDefault true;
      mine.jetbrains = {
        enable = lib.mkDefault false;
        useLatest = lib.mkDefault true;
      };

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
        gucharmap

        speedtest-cli
        graphviz

        kitty
        cachix
        xorg.xdpyinfo
        stable.tigervnc
        sshfs

        # iOS stuff
        #ideviceinstaller
        #ifuse
        #libimobiledevice

        rclone

        ghidra-bin

        _1password-gui
      ];

      #services.dbus.socketActivated = true;

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

          configurationLimit = 30;
          efiSupport = true;
          # allow grub to work with no explicit boot device
          device = "nodev";
          useOSProber = true;
        };
      };

      #services.printing.enable = true;


      # Misc power
      powerManagement.cpuFreqGovernor = lib.mkForce "performance";
      powerManagement.enable = true;


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
        libvirtd.enable = true;
      };

      # dmd is currently broken
      mine.onedrive.enable = false;

      services.fstrim.enable = true;

      mine.prometheus.export.enable = true;
    })
		(mkIf (config.mine.profiles.desktop.enable == false) {
        mine = {
          emacs = {
            enable = false;
            config = {};
          };
          userConfig = {
            programs = {
              notmuch.enable = false;
              firefox = {
                package = null;
                enable = false;
              };
              chromium = {
                package = null;
                enable = false;
              };
            };
          };
        };
      })
      # Always include these options
      {
        environment.homeBinInPath = true;
        documentation = { dev.enable = true; };
        mine.emacs = {
          enable = lib.mkDefault true;

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
        mine.dev.haskell = {
          enable = lib.mkDefault true;
          hoogle.enable = lib.mkDefault true;
        };
        mine.dev.rust = {
          enable = lib.mkDefault true;
          plugins = [ "rust-std" "rust-src" ];
          channel = "stable";
          extraPackages = with pkgs; [
            cargo-about
            cargo-cache
            cargo-edit
            cargo-license
            cargo-show-asm
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
            #cargo-geiger
          ];
        };
        programs.vim.defaultEditor = true;
        mine.vim = {
          enable = lib.mkDefault true;
          colorscheme = "spacecamp";
          extraPlugins = with pkgs.vimPlugins; [ SpaceCamp ];
        };
        programs.thefuck.enable = true;
        services.gpm.enable = true;

        services.lorri = {
          enable = true;
        };
        programs.screen = {
          screenrc = ''
            # for weechat service support, etc
            multiuser on
            acladd normal_user

            # Enable mouse scrolling and scroll bar history scrolling
            termcapinfo xterm* ti@:te@
          '';
        };

      }
  ];
}
