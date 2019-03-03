{ stdenv
, fetchFromGitHub
, rustPlatform
, openssl
, pkgconfig
, feh
, xlibsWrapper
, xorg
}:

let
  moz_overlay = import (builtins.fetchGit https://github.com/mozilla/nixpkgs-mozilla.git );
  pkgs = import <nixpkgs> { overlays = [ moz_overlay ]; };

in rustPlatform.buildRustPackage rec {
  name = "rrbg";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "evanjs";
    repo = "rrbg";
    rev = "1e60365238389e0f9756884e330d1eb6643cfe02";
    sha256 = "00jpfw0ys4xjkw1ssj129c93zdvif5bdh04z8g1x2p6i1bfarn6n";
  };

  nativeBuildInputs = [
    pkgs.latest.rustChannels.stable.cargo
    pkgs.latest.rustChannels.stable.rust
    openssl.dev
    xorg.libXrandr
    xorg.libXinerama
    xlibsWrapper
  ];

  propogatedBuildInputs = [
    feh
  ];


  cargoSha256 = "00jpfw0ys4xjkw1ssj129c93zdvif5bdh04z8g1x2p6i1bfarn6n";

}
