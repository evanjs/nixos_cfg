{ stdenv
, fetchFromGitHub
, rustPlatform
}:

let
  moz_overlay = import (builtins.fetchGit https://github.com/mozilla/nixpkgs-mozilla.git );
  pkgs = import <nixpkgs> { overlays = [ moz_overlay ]; };

in rustPlatform.buildRustPackage rec {
  name = "nget";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "evanjs";
    repo = "nget";
    rev = "b182f81d77470aa9eda7075654390835673a7cbe";
    sha256 = "1cgyl27kikdc62d7cdh2fpgi9ia4wh5bvyhd4wnq1fzidaj3kvrb";
  };

  nativeBuildInputs = [
    pkgs.latest.rustChannels.nightly.cargo
    pkgs.latest.rustChannels.nightly.rust
  ];

  cargoSha256 = "0xm5pmmk0jvvdzkkpg89v20rw89m8cdgppzninzgx1vj09kikcx9";
}
