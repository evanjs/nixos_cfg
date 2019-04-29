{ stdenv, python }:

python.pkgs.buildPythonPackage rec {
  pname = "material_ui";
  version = "0.1.3.6";

  src = python.pkgs.fetchPypi {
    inherit version;
    pname = "material_ui";
    sha256 = "11x1klcyj86x7jivyl672xwimwfxr9ikphrxqqmh5xznbyfx5h03";
  };


  doCheck = false;
}
