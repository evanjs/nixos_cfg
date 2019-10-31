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
  version = "unstable-2019-10-28";

  src = fetchFromGitHub {
    owner = "evanjs";
    repo = "rrbg";
    rev = "ae9b6c137fa9a6348dd6119acd6fab1907f74919";
    sha256 = "1jhs3pi9fl9ncbv5aqdkwnwj3dwh2vvw34i80v2i3mk20fjhp871";
  };

  nativeBuildInputs = [
    xorg.libXrandr
    xorg.libXinerama
    xlibsWrapper
    SDL2
  ];

  doCheck = false;

  cargoSha256 = "1z8rxk2bczg9fafbp2pisjh2p5vsypbz03bn1sy1q6yfvmsc8kim";

}
