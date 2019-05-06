{ config, pkgs, ... }:
let
  moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
  pkgs = import <nixpkgs> { overlays = [ moz_overlay ]; };
  rust-stable = pkgs.latest.rustChannels.stable.rust;
  rust-nightly = pkgs.latest.rustChannels.nightly.rust;
in
{

  imports = [
    ./cargo.nix
    ./cross.nix
    ./documentation
    ./sccache.nix
  ];

  environment.systemPackages = with pkgs; [
    openssl.dev
    pkgconfig
    rustup
  ];
}
