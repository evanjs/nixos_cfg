{ stdenv
, fetchFromGitHub
, makeWrapper
, openssl
, pkgconfig
, cmake
, rustPlatform
, rustChannel
, wrapQtAppsHook
}:

let
  inherit (stdenv) lib;
in
  rustPlatform.buildRustPackage rec {
    name = "rust-qt-binding-generator";
    version = "0.3.4";

    src = fetchFromGitHub {
      owner = "evanjs";
      repo = "rust-qt-binding-generator";
      rev = "7e7ff3b2ded7e16f5dd8c45fb426b5fdb487aea8";
      sha256 = "06bq6wzkc2kyjvb6sl2ryplhmsqyhz58xli2by563bqasj2w5n80";
    };

    cargoSha256 = "0x8cgy9z6a05f09yvx7myh1a7x9q5hdfvqmmgl1b9g6kx319gsx2";

    buildInputs = [
      rustChannel.rust
      rustChannel.cargo
    ];
    nativeBuildInputs = [
      makeWrapper
      openssl.dev
      pkgconfig
      cmake
      wrapQtAppsHook
    ];
  }
