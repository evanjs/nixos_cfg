{ stdenv
, fetchFromGitHub
, makeWrapper
, libressl
, pkgconfig
, rustPlatform
}:

let
  moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
  nixpkgs = import <nixpkgs> { overlays = [ moz_overlay ]; };

in rustPlatform.buildRustPackage rec {
  name = "cross";
  version = "0.1.14";

  src = fetchFromGitHub {
    owner = "rust-embedded";
    repo = "cross";
    rev = "v${version}";
    sha256 = "0yqyc0gj3xsv96nk2cgnvg3w64zll6ari88bp216js7knhydgn3x";
  };

  cargoSha256 = "1w8638h85lwdxfkqi738rhn1dxdzbcmybpjxawvhs78z7r23rnvq";

  buildInputs = [
    nixpkgs.latest.rustChannels.stable.rust
    nixpkgs.latest.rustChannels.stable.cargo
  ];
  nativeBuildInputs = [
    makeWrapper
    libressl
    pkgconfig
  ];
}

