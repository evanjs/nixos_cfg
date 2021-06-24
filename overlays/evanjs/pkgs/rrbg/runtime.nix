{ stdenv
, fetchFromGitHub
, rustPlatform
, openssl
, pkgconfig
, xlibsWrapper
, xorg
, SDL2
}:

rustPlatform.buildRustPackage rec {
  name = "rrbg";
  version = "unstable-2020-04-04";

  src = fetchFromGitHub {
    owner = "evanjs";
    repo = "rrbg";
    rev = "5cfaa5a796cfd18fd347c701a89d5137aeb61e9f";
    sha256 = "1k8rvilky64mwkpa7jccama8bjd9g8gyndx3slhvwr3gryhm2f2r";
  };

  buildInputs = [
    SDL2
  ];

  nativeBuildInputs = [
    xorg.libXrandr
    xorg.libXinerama
    xlibsWrapper
  ];

  doCheck = false;

  cargoSha256 = "0zai3xis4rnv1gziz5id2daqql4r45gcb9sv8zkv3056kcwz2lyq";

}
