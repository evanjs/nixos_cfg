{ stdenv, fetchFromGitHub, rustPlatform, dbus, pkgconfig }:

rustPlatform.buildRustPackage rec {
  name = "power-warn";
  version = "unstable-2020-02-03";

  src = fetchFromGitHub {
    owner = "yoshuawuyts";
    repo = "power-warn";
    rev = "052133d6707bde348b745b593279e4ebb2e8f0db";
    sha256 = "1qcphw6d32s65aiqg60mpg8dzwwdxh2vfkpw8jy91a7xrk3hk65n";
  };

  nativeBuildInputs = [
    dbus
    pkgconfig
  ];

  cargoSha256 = "00636qqy7vacam1bfv2w0dyj1ayr88y3iy2662mriidb75sxdlhd";
}
