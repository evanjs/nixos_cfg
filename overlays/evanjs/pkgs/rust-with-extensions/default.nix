{ config, rustChannel, ... }:
let
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
  base = (rustChannel.rust.override { extensions = base-extensions; });
  std-only = (rustChannel.rust.override { extensions = std-only; });
  with-debug = (rustChannel.rust.override { extensions = base-extensions ++ debug; });
  with-utilities = (rustChannel.nightly.rust.override { extensions = base-extensions ++ utilities; });
  full = (rustChannel.nightly.rust.override { extensions = base-extensions ++ debug ++ utilities; });
}
