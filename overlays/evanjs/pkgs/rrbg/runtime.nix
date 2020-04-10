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

  cargoSha256 = "0nfg7361n1xngc7fnnqmq7vhr3kla6y8dyv4wfx5mbl1l6nxy4jd";

}
