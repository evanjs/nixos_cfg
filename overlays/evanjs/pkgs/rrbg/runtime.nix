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
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "evanjs";
    repo = "rrbg";
    rev = "15aeb0ac302ee70850d569bbebfb018c2797ea25";
    sha256 = "1qzfq909gsdzfw6ygig3ng9031dwpx3bz45dafm56bnd46mrwyzc";
  };

  nativeBuildInputs = [
    xorg.libXrandr
    xorg.libXinerama
    xlibsWrapper
    SDL2
  ];

  doCheck = false;

  cargoSha256 = "035nidsg96hicf19nylkaqrg467d2dyaswj04nnh53ahf11wlcm8";

}
