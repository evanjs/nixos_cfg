self: super:
let
  moz_overlay = import (builtins.fetchGit https://github.com/mozilla/nixpkgs-mozilla.git );
  unstable = import <nixpkgs-unstable> { overlays = [ moz_overlay ]; };
  unstableRustPlatform = unstable.rustPlatform;
  unstableRust = unstable.latest.rustChannels.stable.rust;
  unstableCargo = unstable.latest.rustChannels.stable.cargo;
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
    nightly-rust-with-extensions = callPackage ../nightly-rust { };
    nget = callPackage ../nget { };
    polychromatic = callPackage ../polychromatic { };
    zsh-powerlevel9k = callPackage ../shells/zsh/zsh-powerlevel9k { };
    power-warn = callPackage ../tools/misc/power-warn { };
  
    qrbooru = callQPackage ../qrbooru { };
    rrbg = callPackage ../rrbg { };
    runescape-launcher = callPackage ../runescape-launcher { };
    rust-qt-binding-generator = callQPackage ../rust-qt-binding-generator { };
  }
