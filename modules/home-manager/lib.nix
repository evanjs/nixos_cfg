{ config, pkgs, ... }:
let
  HOME = config.home.homeDirectory;

  functions = {
    writeShellScriptsBin = builtins.mapAttrs (name: text:
    let deriv = pkgs.writeShellScriptBin name text;
    in deriv // { bin = "${deriv}/bin/${deriv.name}"; }
    );

    reduceAttrsToString = sep: fn: attrs:
    builtins.concatStringsSep sep (pkgs.lib.mapAttrsToList fn attrs);
  };
  paths = rec {
    userBin = "${HOME}/.nix-profile/bin";
    systemBin = "/run/current-system/sw/bin";
    userSrc = "${HOME}/src";
  };
  sessionVariables = rec {
    # Hack to get home-manager to reload session variables on switches
    __HM_SESS_VARS_SOURCED = "";

    # HiDPI stuff
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    # Big discussion at Nixpkgs. Can't remember why it's here but it fixes shit.
    GDK_PIXBUF_MODULE_FILE = "${pkgs.librsvg.out}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache";

    PASSWORD_STORE_DIR = "${HOME}/.local/share/pass";
  };
in

  with config; {
    lib = {
      inherit functions paths sessionVariables;
    };
  }

