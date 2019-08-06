{ stdenv, fetchurl, ... }:
{
  stdenv.mkDerivation = rec {
    name = "cht-sh";
    version = "unstable-2019-08-06";
    rev = version;

    src = fetchurl {
      name = "cht.sh";
      url = "https://cheat.sh/:cht.sh";
      sha256 = "1zrn9lp0fk71ml4mh0w99zr156mc69b9931sc7dyynkdm2wjs1mr";
    };

    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/
    '';
  };
}
