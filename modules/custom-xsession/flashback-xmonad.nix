{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.services.xserver.displayManager.gdm.xmonad-support;
in
  {
    options.services.xserver.displayManager.gdm.xmonad-support = {
      enable = mkEnableOption "XMonad support for gdm";
    };

    config = lib.mkIf cfg.enable {
      services.xserver.displayManager.extraSessionFilePackages =
        let gnome-flashback-xmonad = {wmName, wmLabel, wmCommand}: pkgs.callPackage ({ stdenv, gnome3, bash, haskellPackages, glib, wrapGAppsHook }: stdenv.mkDerivation {
          name = "gnome-flashback-${wmName}";

          buildInputs = [ gnome3.gnome-flashback gnome3.gnome-panel bash haskellPackages.xmonad glib ];
          nativeBuildInputs = [ wrapGAppsHook ];

          unpackPhase = "true";

          installPhase = ''
            mkdir -p $out/libexec
            cat << EOF > $out/libexec/gnome-flashback-${wmName}
      #!${bash}/bin/sh

            if [ -z \$XDG_CURRENT_DESKTOP ]; then
            export XDG_CURRENT_DESKTOP="GNOME-Flashback:GNOME"
            fi

            exec ${gnome3.gnome-session}/bin/gnome-session --session=gnome-flashback-${wmName} --disable-acceleration-check "\$@"
            EOF
            chmod +x $out/libexec/gnome-flashback-${wmName}

            mkdir -p $out/share/gnome-session/sessions
            cat << 'EOF' > $out/share/gnome-session/sessions/gnome-flashback-${wmName}.session
            [GNOME Session]
            Name=GNOME Flashback (${wmLabel})
            RequiredComponents=${wmName};gnome-flashback-init;gnome-flashback;gnome-panel;org.gnome.SettingsDaemon.A11ySettings;org.gnome.SettingsDaemon.Clipboard;org.gnome.SettingsDaemon.Color;org.gnome.SettingsDaemon.Datetime;org.gnome.SettingsDaemon.Housekeeping;org.gnome.SettingsDaemon.Keyboard;org.gnome.SettingsDaemon.MediaKeys;org.gnome.SettingsDaemon.Mouse;org.gnome.SettingsDaemon.Power;org.gnome.SettingsDaemon.PrintNotifications;org.gnome.SettingsDaemon.Rfkill;org.gnome.SettingsDaemon.ScreensaverProxy;org.gnome.SettingsDaemon.Sharing;org.gnome.SettingsDaemon.Smartcard;org.gnome.SettingsDaemon.Sound;org.gnome.SettingsDaemon.Wacom;org.gnome.SettingsDaemon.XSettings;
            EOF

            mkdir -p $out/share/applications
            cat << 'EOF' > $out/share/applications/${wmName}.desktop
            [Desktop Entry]
            Type=Application
            Encoding=UTF-8
            Name=${wmLabel}
            Exec=${wmCommand}
            NoDisplay=true
            X-GNOME-WMName=${wmLabel}
            X-GNOME-Autostart-Phase=WindowManager
            X-GNOME-Provides=windowmanager
            X-GNOME-Autostart-Notify=false
            EOF

            mkdir -p $out/share/xsessions
            cat << EOF > $out/share/xsessions/gnome-flashback-${wmName}.desktop
            [Desktop Entry]
            Name=GNOME Flashback (${wmLabel})
            Comment=This session logs you into GNOME Flashback with ${wmLabel}
            Exec=$out/libexec/gnome-flashback-${wmName}
            TryExec=${wmCommand}
            Type=Application
            DesktopNames=GNOME-Flashback;GNOME;
            EOF
          '';
        })
        {};
        in [ (gnome-flashback-xmonad { wmName = "xmonad"; wmLabel = "XMonad"; wmCommand = "${pkgs.haskellPackages.xmonad}/bin/xmonad"; } ) ];
      };
    }
