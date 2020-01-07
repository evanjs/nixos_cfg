{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.mine.taffybar;
  taffybar = pkgs.callPackage ../../../pkgs/pkgs/taffybar-with-packages.nix {
  #taffybar = pkgs.mine.taffybar-with-packages {
    ghcWithPackages = cfg.haskellPackages.ghcWithPackages;
    packages = self: cfg.extraPackages self;
  };
  taffybarBin = pkgs.writers.writeHaskell "taffybar" {
    ghc = cfg.haskellPackages.ghc;
    libraries = [ cfg.haskellPackages.taffybar ]
    ++ (with cfg.haskellPackages; [ ]);
  } cfg.config;
in {

  options.mine.taffybar = {
    enable = mkEnableOption "taffybar config";
    package = mkOption {
      description = "The taffybar package to use";
      default = taffybar;
    };

    haskellPackages = mkOption {
      default = pkgs.haskellPackages;
      defaultText = "pkgs.haskellPackages";
      example = literalExample "pkgs.haskell.packages.ghc784";
      description = ''
        haskellPackages used to build Taffybar and other packages.
        This can be used to change the GHC version used to build
        Taffybar and the packages listed in
        <varname>extraPackages</varname>.
      '';
    };

    extraPackages = mkOption {
      default = self: [ ];
      defaultText = "self: []";
      example = literalExample ''
        haskellPackages: [
          haskellPackages.xmonad-contrib
          haskellPackages.monad-logger
        ]
      '';
      description = ''
        Extra packages available to ghc when rebuilding Taffybar. The
        value must be a function which receives the attrset defined
        in <varname>haskellPackages</varname> as the sole argument.
      '';
    };

    config = mkOption {
      default = null;
      type = with lib.types; nullOr (either path str);
      description = ''
        Configuration from which XMonad gets compiled. If no value
        is specified, the xmonad config from $HOME/.xmonad is taken.
        If you use xmonad --recompile, $HOME/.xmonad will be taken as
        the configuration, but on the next restart of display-manager
        this config will be reapplied.
      '';
      example = ''
        import XMonad

        main = launch defaultConfig
               { modMask = mod4Mask -- Use Super instead of Alt
               , terminal = "urxvt"
               }
      '';
    };
  };

  config = mkIf cfg.enable {
    services = {
      dbus.packages = [ pkgs.at-spi2-core ];
      upower.enable = true;
    };

    mine = {
      xUserConfig = {
        systemd.user.services = {
          taffybar = {
            Service = {
              ExecStart = "${cfg.package}/bin/taffybar";
              Restart = "on-failure";
            };
            Unit = {
              Description = "Taffybar desktop bar";
              After = [ "graphical-session-pre.target" ];
              PartOf = [ "graphical-session.target" ];
            };
            Install = { WantedBy = [ "graphical-session.target" ]; };
          };
        };
        xsession.importedVariables = [ "GDK_PIXBUF_MODULE_FILE" ];
      };
      userConfig = {
        xdg.configFile."taffybar/taffybar.hs" = {
          source = ./taffybar.hs;
          #onChange = ''
            #echo "Recompiling taffybar"
            #${taffybarBin}
          #'';
        };
        gtk.iconTheme = {
          name = "hicolor";
          package = pkgs.hicolor-icon-theme;
        };
      };
    };
    environment.systemPackages = [ taffybar ];
  };
}
