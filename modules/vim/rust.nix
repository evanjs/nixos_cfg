#let
  #pkgs = import <nixpkgs> { };
  #rust-language-server = ((pkgs.latest.rustChannels.stable.rust.override { extensions = [ "rls-preview" ]; }));
  #rust-stable = pkgs.latest.rustChannels.stable.rust;
  #rust-nightly = pkgs.latest.rustChannels.nightly.rust;
  #environment.systemPackages = with pkgs; [
    #stable-rust
  #];
#in
#''
#"" Rust Settings {{{
#let g:rustfmt_autosave = 1

#let g:LanguageClient_serverCommands = { 'rust': ['${rust-nightly}/bin/rls'] }
#"}}}
##''
