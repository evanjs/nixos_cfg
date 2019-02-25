{ stdenv
, fetchFromGitHub
, buildGoPackage
}:

buildGoPackage rec {
  name = "exercism-${version}";
  version = "3.0.11";

  goPackagePath = "github.com/exercism/cli";

  src = fetchFromGitHub {
    owner = "exercism";
    repo = "cli";
    rev = "v${version}";
    sha256 = "1wg23bvibsk6j4iqwyw35wl9plfwdqxiql81zci7r1x4d5cp26av";
  };

  goDeps = ./deps.nix;

  buildFlags = "--tags release";
}
