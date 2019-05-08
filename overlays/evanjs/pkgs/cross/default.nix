{ stdenv
, fetchFromGitHub
, makeWrapper
, libressl
, pkgconfig
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "cross";
  version = "1.15-dev";

  src = fetchFromGitHub {
    owner = "rust-embedded";
    repo = "cross";
    rev = "718a19cd68fb09428532d1317515fe7303692b47";
    sha256 = "1bfm8f8z5818bjaxff6jzfa28v844vjd2ldl6g1q82wl7iwrxbqk";
  };

  cargoSha256 = "0y2nllc7k2j5ia9w69wnba6vr4l6hagsf5yjny761hz3w027wagm";

  nativeBuildInputs = [
    libressl
    pkgconfig
  ];
}

