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

  cargoSha256 = "1lafzin92h1hb1hqmbrsxja44nj8mpbsxhwcjr6rf5yrclgwmcxj";

  nativeBuildInputs = [
    openssl.dev
    pkgconfig
  ];

  meta = with lib; {
    description = "sccache is ccache with cloud storage";
    homepage = "https://github.com/mozilla/sccache";
    license = licenses.asl20;
    platforms = platforms.all;
  };
}
