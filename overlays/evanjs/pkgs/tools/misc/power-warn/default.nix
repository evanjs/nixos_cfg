{ stdenv, fetchFromGitHub, rustPlatform, dbus, pkgconfig }:

rustPlatform.buildRustPackage rec {
  name = "power-warn";
  version = "unstable-2019-06-26";

  src = fetchFromGitHub {
    owner = "yoshuawuyts";
    repo = "power-warn";
    rev = "784706544645aa75fd39251e40460a4d9579cdd5";
    sha256 = "16lyjprwdfpwv0kyyi41lmxx5i0r8gnv1inhwmmnd05wf59l40nw";
  };

  nativeBuildInputs = [
    dbus
    pkgconfig
  ];

  cargoSha256 = "170y6py1dviph2l1xwqy7svm5gafr41h5jhjz6x4jqc9pkqba6v7";
}
