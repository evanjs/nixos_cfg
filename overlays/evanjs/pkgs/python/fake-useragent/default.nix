{ pkgs
, lib
, stdenv
, fetchFromGitHub
}:
let
  python = import ./requirements.nix { inherit pkgs; };
in
  {
    fake-useragent = python.mkDerivation rec {
      pname = "fake-useragent";
      version = "0.1.11";

      src = fetchFromGitHub {
        owner = "hellysmile";
        repo = "fake-useragent";
        rev = "a55c4dc294883c73231e085fca34ab5a8e2bc1f1";
        sha256 = "01b0zwd4bvxmc8gwd859sns2f953ns0gygkkv7m447x6vdsymzkj";
      };

      propagatedBuildInputs = builtins.attrValues python.packages;

      doCheck = false;
    };
  }
