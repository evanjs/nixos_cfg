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
  pname = "cross";
  version = "1.15-dev";

  src = fetchFromGitHub {
    owner = "rust-embedded";
    repo = "cross";
    rev = "718a19cd68fb09428532d1317515fe7303692b47";
    sha256 = "1bfm8f8z5818bjaxff6jzfa28v844vjd2ldl6g1q82wl7iwrxbqk";
  };

  cargoSha256 = "0y2nllc7k2j5ia9w69wnba6vr4l6hagsf5yjny761hz3w027wagm";

  buildInputs = [
    nixpkgs.latest.rustChannels.stable.rust
    nixpkgs.latest.rustChannels.stable.cargo
  ];
  nativeBuildInputs = [
    libressl
    pkgconfig
  ];
}

