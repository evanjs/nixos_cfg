{ pkgs
, lib
, stdenv
, fetchFromGitHub
}:
let
  python = import ./requirements.nix { inherit pkgs; };
in
  {
    scrapy-fake-useragent = python.mkDerivation rec {
      name = "scrapy-fake-useragent";

      src = fetchFromGitHub {
        owner = "alecxe";
        repo = "scrapy-fake-useragent";
        rev = "d9ab527b7b4dcf2430095ab91c23885190e7b084";
        sha256 = "03il4jdrpzsnqacn13df58lz0hnzny9l6kb56gzl5dprdpkpry1m";
      };

      propagatedBuildInputs = builtins.attrValues python.packages;
    };
  }
