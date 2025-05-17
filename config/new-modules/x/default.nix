{ config, lib, pkgs, ... }:

with lib;

{

  options.mine.x.enable = mkEnableOption "X config";

  config = mkIf config.mine.x.enable {

    programs.dconf.enable = true;

    mine.live-wallpaper.enable = false;

    services.logind.extraConfig = ''
      HandlePowerKey=suspend
    '';

    services.xserver = {
      enable = lib.mkDefault true;
      exportConfiguration = true;

      displayManager = {
        autoLogin = {
          enable = mkDefault false;
          user = mkDefault "evanjs";
        };
        gdm = {
          enable = lib.mkDefault true;
          autoSuspend = false;
        };

        sessionCommands = ''
          # Set GTK_DATA_PREFIX so that GTK+ can find the themes
          export GTK_DATA_PREFIX=${config.system.path}

          # find theme engines
          export GTK_PATH=${config.system.path}/lib/gtk-3.0:${config.system.path}/lib/gtk-2.0
        '';
      };

      libinput = {
        accelProfile = "flat";
      };
    };

    xdg = {
      mime.enable = true;
    };

    mine.userConfig.xdg.mimeApps =
      let
        chromium = "chromium-browser.desktop";
      in
      {
        enable = true;
        defaultApplications = {
          "application/xhtml+xml" = chromium;
          "text/html" = chromium;
          "text/xml" = chromium;
          "x-scheme-handler/http" = chromium;
          "x-scheme-handler/https" = chromium;
        };
      };

    fonts = {
      enableFontDir = true;
      enableGhostscriptFonts = true;
      packages = with pkgs; [
        #corefonts
        #vistafonts
        nerd-fonts.jetbrains-mono
        nerd-fonts.fira-mono
        nerd-fonts.noto
        ipaexfont
        noto-fonts-cjk-sans
        noto-fonts-emoji
        # TODO: try and integrate this with emacs config so it isn't explicitly defined in the main X config
        emacs-all-the-icons-fonts
      ];
    };

    environment.systemPackages = with pkgs; [
      feh
      libnotify
      gnome-font-viewer
      gnome-terminal
      guake
      xclip
      #evince
      vlc
      #pcmanfm
      arandr
      xorg.xmessage
      lxappearance
      #arc-theme
      gtk_engines
      gtk-engine-murrine
      #shotcut #video editor
      xbindkeys
      xwinwrap
      xbindkeys-config
      dmenu
      xorg.xev
      haskellPackages.xmobar
      xdg-user-dirs
      d-spy
    ];


    mine.xUserConfig = {

      services.picom = {
        enable = true;
        activeOpacity = 0.90;

        shadowExclude = [
          "bounding_shaped && !rounded_corners"
        ];

        fade = true;
        fadeDelta = 5;
        vSync = true;
        opacityRule = [
          "100:class_g   *?= 'Chromium-browser'"
          "100:class_g   *?= 'Firefox'"
          "100:class_g   *?= 'gitkraken'"
          "100:class_g   *?= 'emacs'"
          "100:class_g   ~=  'jetbrains'"
          "100:class_g   *?= 'slack'"
        ];
      };

      services.unclutter = {
        enable = true;
      };

      services.redshift.enable = true;

      xsession = {
        enable = true;
        numlock.enable = true;

        pointerCursor = {
          name = "breeze_cursors";
          size = 16;
          package = pkgs.plasma5Packages.breeze-qt5;
        };
        
       preferStatusNotifierItems = true;
      };

      home.packages = with pkgs; [
        mpv
        mine.pics
        #thunderbird
        #helvetica-neue-lt-std
      ];

      programs.chromium = {
        extensions = [
          "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1Password X
          "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
          "gcbommkclmclpchllfjekcdonpmejbdp" # HTTPS Everywhere
          "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
        ];
      };

      programs.zsh.shellAliases = {
        pbcopy = "${pkgs.xclip}/bin/xclip -selection clipboard";
        pbpaste = "${pkgs.xclip}/bin/xclip -selection clipboard -o";
        aniwp = "xwinwrap -ov -fs -ni -- mpv --loop=inf -wid WID --panscan=1";
      };

      programs.rofi = {
        enable = true;
        theme = "Monokai";
        terminal = config.mine.terminal.binary;
      };

    };
  };
}
