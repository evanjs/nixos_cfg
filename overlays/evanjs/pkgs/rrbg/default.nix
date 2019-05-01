{ stdenv
, fetchFromGitHub
, rustPlatform
, openssl
, pkgconfig
, feh
, xlibsWrapper
, xorg
, SDL2
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
    rev = "497a6440f0d50633d9e04b588f73e64a0e53fdfe";
    sha256 = "0zx43n4js9za7gq5sp14w7j9gpk788nzcfyv8l3j382lmjy56f8y";
  };

  nativeBuildInputs = [
    pkgs.latest.rustChannels.nightly.cargo
    pkgs.latest.rustChannels.nightly.rust
    openssl.dev
    xorg.libXrandr
    xorg.libXinerama
    xlibsWrapper
    SDL2
  ];

  #propogatedNativeBuildInputs = [
  #];

  propagatedBuildInputs = [
    feh
  ];

  doCheck = false;

  cargoSha256 = "0m7bviq3bjnq9mybm4xxxm97x2d8cr80wqc2mjhs3mh44g5alasr";

}
