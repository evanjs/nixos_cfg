{ stdenv, python, fetchgit }:

python.pkgs.buildPythonPackage rec {
  pname = "kivymd";
  version = "0.1.2";

  src = fetchgit {
    url = "https://gitlab.com/kivymd/KivyMD";
    rev = "19e587e64eede4d80aa13757e2a429c595f96b48";
    sha256 = "0vy3b5aqak5r33biv2w2i79l2g5k9ci8r2gpgdg3wla0hdm7gp8q";
  };

  doCheck = false;
}
