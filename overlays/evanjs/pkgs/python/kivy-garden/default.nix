{ stdenv, python }:

python.pkgs.buildPythonPackage rec {
  pname = "Kivy-Garden";
  version = "0.1.4";

  src = python.pkgs.fetchPypi {
    inherit version;
    pname = "kivy-garden";
    sha256 = "c256f42788421273a08fbb0a228f0fb0e80dd86b629fb8c0920507f645be6c72";
  };

  pythonPath = with python.pkgs; [ requests ];

  doCheck = false;
}
