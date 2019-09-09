{ config, lib, pkgs, ... }:

with lib;

{

  options.mine.x.enable = mkEnableOption "X config";

  config = mkIf config.mine.x.enable {

    programs.dconf.enable = true;

    mine.dunst.enable = true;

    mine.live-wallpaper.enable = true;

    mine.compton.enable = true;

    services.logind.extraConfig = ''
      HandlePowerKey=suspend
    '';

    services.xserver = {
      enable = true;
      exportConfiguration = true;

      displayManager = {
        gdm = {
          enable = true;
          autoLogin = {
            enable = false;
            user = "evanjs";
          };
        };

        sessionCommands = ''
          # Set GTK_DATA_PREFIX so that GTK+ can find the themes
          export GTK_DATA_PREFIX=${config.system.path}

          # find theme engines
          export GTK_PATH=${config.system.path}/lib/gtk-3.0:${config.system.path}/lib/gtk-2.0
        '';
      };
    };

    fonts = {
      enableFontDir = true;
      enableGhostscriptFonts = true;
      fonts = with pkgs; [
        nerdfonts
        #hanazono
        ipaexfont
        #mplus-outline-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        noto-fonts
        #wqy_zenhei
        #input-fonts
      ];
    };

    environment.systemPackages = with pkgs; [
      feh
      libnotify
      gnome3.gnome-font-viewer
      gnome3.gnome_terminal
      guake
      xclip
      #evince
      vlc
      #pcmanfm
      arandr
      xorg.xmessage
      lxappearance-gtk3
      #arc-theme
      gtk_engines
      gtk-engine-murrine
      #shotcut #video editor
      xbindkeys
      xwinwrap
      xbindkeys-config
      dmenu
      xlibs.xev
      haskellPackages.xmobar
      xtrlock-pam
    ];


    mine.xUserConfig = {

      services.unclutter = {
        enable = true;
      };

      #services.redshift.enable = true;

      xsession = {
        enable = true;
        numlock.enable = true;

        pointerCursor = {
          name = "breeze_cursors";
          size = 16;
          package = pkgs.plasma5.breeze-qt5;
        };
      };

      home.packages = with pkgs; [
        mpv
        mine.pics
        #thunderbird
        helvetica-neue-lt-std
        mine.arcred
      ];

      #services.random-background = {
        #enable = true;
        #imageDirectory = "%h/Pictures/wallpapers/";
        #interval = "120";
      #};

      programs.zsh.shellAliases = {
        pbcopy = "${pkgs.xclip}/bin/xclip -selection clipboard";
        pbpaste = "${pkgs.xclip}/bin/xclip -selection clipboard -o";
        aniwp = "xwinwrap -ov -fs -ni -- mpv --loop=inf -wid WID --panscan=1";
      };

    };
  };

}
