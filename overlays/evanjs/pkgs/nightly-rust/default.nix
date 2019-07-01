{ config, pkgs, ... }:
let

  # TODO: Can we move these higher to reduce duplicate instances of moz_overlay, etc?
  moz_overlay = import (builtins.fetchGit https://github.com/mozilla/nixpkgs-mozilla.git );
  pkgs = import <nixpkgs> { overlays = [ moz_overlay ]; };

  /* Extensions may be one of:
  clippy-preview
  miri-preview
  rls-preview
  rustfmt-preview
  llvm-tools-preview
  lldb-preview
  rust-analysis
  rust-std
  rust-src
  */

    # TODO: don't use these extensions until we can fail gracefully - i.e. ignore these extensions if they cannot be downloaded
    #"clippy-preview"
    #"rustfmt-preview"
    #"rust-analysis"
    #"llvm-tools-preview"

    base-extensions = [
      "rust-std"
      "rust-src"
    ];
    
    debug = [
      "llvm-tools-preview"
    ];

    std-only = [
      "rust-std"
    ];
    
    utilities = [
      "clippy-preview"
      "rustfmt-preview"
      "rust-analysis"
    ];

in {
  base = (pkgs.latest.rustChannels.nightly.rust.override { extensions = base-extensions; });
  std-only = (pkgs.latest.rustChannels.nightly.rust.override { extensions = std-only; });
  with-debug = (pkgs.latest.rustChannels.nightly.rust.override { extensions = base-extensions ++ debug; });
  with-utilities = (pkgs.latest.rustChannels.nightly.rust.override { extensions = base-extensions ++ utilities; });
  full = (pkgs.latest.rustChannels.nightly.rust.override { extensions = base-extensions ++ debug ++ utilities; });
}
