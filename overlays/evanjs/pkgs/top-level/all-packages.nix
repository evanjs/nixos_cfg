self: super:
let
  unstable = import <nixpkgs-unstable> { };
  rustPlatform = pkgs.rustPlatform;
  #stableRust = pkgs.rustChannels.stable;
  #nightlyRust = pkgs.latest.rustChannels.nightly;
  callPackage = self.callPackage;
  callPackages = self.callPackages;
  callQPackage = self.libsForQt5.callPackage;
  pkgs = self.pkgs;
  python37 = self.pkgs.python37;
in
  rec {
    ### applications 
    ### networking
    ### instant-messengers
    slack = callPackage ../applications/networking/instant-messengers/slack { };
    slack-theme-black = callPackage ../applications/networking/instant-messengers/slack/dark-theme.nix { };
    slack-dark = pkgs.slack.override { theme = slack-theme-black; };

    ### rust utilities
    bingrep = callPackage ../development/tools/bingrep { };

    booru = callPackage ../booru { };
    cross = callPackage ../cross { };
    exercism = callPackage ../tools/exercism { };
    kivy = callPackage ../python/kivy { python = python37; };
    kivy-garden = callPackage ../python/kivy-garden { python = python37; };
    kivymd = callPackage ../python/kivymd { python = python37; kivy = kivy; };
    material-ui = callPackage ../python/material-ui { python = python37; };
    mcdex = callPackage ../games/mcdex { };
    nget = callPackage ../nget { };
    polychromatic = callPackage ../polychromatic { };
    #rust-with-extensions = callPackage ../rust-with-extensions { rustChannel = nightlyRust; };
    power-warn = callPackage ../tools/misc/power-warn { };

    #qrbooru = callQPackage ../qrbooru { rustChannel = nightlyRust; };
    rrbg = callPackage ../rrbg { };
    runescape-launcher = callPackage ../runescape-launcher { };
    #rust-qt-binding-generator = callQPackage ../rust-qt-binding-generator { rustChannel = stableRust; };
    
    ua-expert = callPackage ../tools/misc/ua-expert { };
    bash-insulter = callPackage ../tools/misc/bash-insulter { };
  }
