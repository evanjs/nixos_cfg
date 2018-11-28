{ pkgs ? import <nixpkgs>{} } :
let
  stdenv = pkgs.stdenv;
  buildPythonPackage = pkgs.buildPythonPackage;
  fetchPypi = pkgs.fetchPypi;

in
  stdenv.mkDerivation rec {
    name = "web-greeter-${version}";
    version = "2016-07-13";
    src = fetchGit {
      url = "https://github.com/Antergos/web-greeter";
    };

    buildInput = [ pgi wither ];

    shellHook = ''
  # set SOURCE_DATE_EPOCH so that we can use python wheels
      SOURCE_DATE_EPOCH=$(date +%s)
      virtualenv --no-setuptools venv
      export PATH=$PWD/venv/bin:$PATH
      pip install -r requirements.txt
    '';

    patchPhase = ''
      patchShebangs Makefile
      patchShebangs build/utils.sh
    '';
  }
