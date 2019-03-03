{ stdenv
, fetchFromGitHub
, makeWrapper
, openssl
, pkgconfig
, cmake
#, qtbase
#, qtsvg
#, qtdeclarative
, full
, rustPlatform
}:

let
  inherit (stdenv) lib;
  moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
  nixpkgs = import <nixpkgs> { overlays = [ moz_overlay ]; };

in rustPlatform.buildRustPackage rec {
  name = "rust-qt-binding-generator";
  version = "0.3.2";

  src = fetchFromGitHub {
    owner = "evanjs";
    repo = "rust-qt-binding-generator";
    rev = "latest";
    sha256 = "1wik7lln1y173ps8kxln7nygbd5d3x412d91n2sw7jqnzj0v22dg";
  };

  cargoSha256 = "1d0xcb6x6pq9z602h3rxf9124fsg0qhxad66rnjfr1hn6yxgqqkj";

  buildInputs = [
    nixpkgs.latest.rustChannels.stable.rust
    nixpkgs.latest.rustChannels.stable.cargo
  ];
  nativeBuildInputs = [
    makeWrapper
    openssl.dev
    pkgconfig
    cmake
    full
    #qtbase.dev
    #qtsvg.dev
    #qtdeclarative.dev
  ];
}

