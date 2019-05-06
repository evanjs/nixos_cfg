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

  cargoSha256 = "1va2fbkiq96m3h2jahc0avdzndgg82giln2llbmgvkhbml0y1lrn";

  nativeBuildInputs = [
    libressl
    pkgconfig
  ];
}

