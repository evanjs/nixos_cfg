{ stdenv
, fetchFromGitHub
, rustPlatform
, openssl
, pkgconfig
}:

let
  moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
  pkgs = import <nixpkgs> { overlays = [ moz_overlay ]; };

in stdenv.mkDerivation rec {
  name = "booru";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "evanjs";
    repo = "booru";
    rev = "caed94252a230a4bb7557a31b94102c78280373c";
    sha256 = "1c1iyjfi9z6a6q44p6m0141jck6qvqa5fsw96x7kp0z6cxmrj581";
  };

  buildCmd = "cargo build";
  installCmd = ''
    mkdir $out/
    cp target/libbooru.d libbooru.rlib $out/
  '';

  #cargoSha256 = "1c1iyjfi9z6a6q44p6m0141jck6qvqa5fsw96x7kp0z6cxmrj581";
}
