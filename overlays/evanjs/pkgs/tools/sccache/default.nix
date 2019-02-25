{ stdenv
, lib
, rustPlatform
, fetchFromGitHub
, openssl
, pkgconfig
}:

rustPlatform.buildRustPackage rec {
  name = "sccache-${version}";
  version = "0.2.8";
  src = fetchFromGitHub {
    owner = "mozilla";
    repo = "sccache";
    rev = "${version}";
    sha256 = "08v8s24q6246mdjzl5lirqg0csxcmd17szmw4lw373hvq4xvf0yk";
  };

  doCheck = false;

  cargoSha256 = "1gq115bi4abm4l7yyxsjmph1zr71r8d9694yhfbk2ic6qviaycn7";

  nativeBuildInputs = [
    openssl.dev
    pkgconfig
  ];

  meta = with lib; {
    description = "sccache is ccache with cloud storage";
    homepage = "https://github.com/mozilla/sccache";
    license = with licenses; [ apache-2.0 ];
    platforms = platforms.all;
  };
}
