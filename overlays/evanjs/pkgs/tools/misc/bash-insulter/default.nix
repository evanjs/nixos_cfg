{ stdenv
, fetchFromGitHub }:

with stdenv.lib;

stdenv.mkDerivation rec {
  version = "2019-12-02";
  name = "bash-insulter";

  src = fetchFromGitHub {
    owner = "hkbakke";
    repo = "bash-insulter";
    rev = "a50e55b6f26e11009858db52b586d79ad9c808b1";
    sha256 = "1dk86l9rg43szfkd0nvn1brclkvvi6ypd1rza819f6gnfjnxckb3";
  };

  installPhase = ''
    mkdir -p $out/share/bash-insulter
    install -m644 src/bash.command-not-found $out/share/bash-insulter
  '';

  meta = with stdenv.lib; {
    description = "Insults the user when typing wrong command";
    license = licenses.mit;
    maintainers = with maintainers; [ evanjs ];
  };
}
