self: super:
let
  unstable = import <nixpkgs-unstable> { };
  rustPlatform = unstable.rustPlatform;
  stableRust = unstable.latest.rustChannels.stable;
  nightlyRust = unstable.latest.rustChannels.nightly;
  callPackage = self.callPackage;
  callPackages = self.callPackages;
  callQPackage = self.libsForQt5.callPackage;
  pkgs = self.pkgs;
in 
  rec {
    ### applications 
    slack = callPackage ../applications/networking/instant-messengers/slack { };
    slack-theme-black = callPackage ../applications/networking/instant-messengers/slack/dark-theme.nix { };
    slack-dark = pkgs.slack.override { theme = slack-theme-black; };

    ### rust utilities
    bingrep = callPackage ../development/tools/bingrep { };

    booru = callPackage ../booru { };
    cross = callPackage ../cross { };
    exercism = callPackage ../tools/exercism { };
    kivy = callPackage ../python/kivy { python = self.python37; };
    kivy-garden = callPackage ../python/kivy-garden { python = self.python37; };
    kivymd = callPackage ../python/kivymd { python = self.python37; };
    material-ui = callPackage ../python/material-ui { python = self.python37; };
    mcdex = callPackage ../games/mcdex { };
    nget = callPackage ../nget { };
    polychromatic = callPackage ../polychromatic { };
    rust-with-extensions = callPackage ../rust-with-extensions { rustChannel = nightlyRust; };
    zsh-powerlevel9k = callPackage ../shells/zsh/zsh-powerlevel9k { };
    power-warn = callPackage ../tools/misc/power-warn { };
  
    qrbooru = callQPackage ../qrbooru { rustChannel = nightlyRust; };
    rrbg = callPackage ../rrbg { };
    runescape-launcher = callPackage ../runescape-launcher { };
    rust-qt-binding-generator = callQPackage ../rust-qt-binding-generator { rustChannel = stableRust; };
  }
