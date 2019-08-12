self: super:
let
  pkgs = import <nixpkgs-unstable> { };
  rust-language-server = ((pkgs.rustChannels.stable.rust.override { extensions = [ "rls-preview" ]; }));
  rust-stable = pkgs.rustChannels.stable.rust;
  rust-nightly = pkgs.rustChannels.nightly.rust;
  environment.systemPackages = with pkgs; [
    stable-rust
  ];
in
''
"" Rust Settings {{{
let g:rustfmt_autosave = 1

let g:LanguageClient_serverCommands = { 'rust': ['${rust-nightly}/bin/rls'] }
"}}}
''
