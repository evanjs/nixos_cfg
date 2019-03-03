{ fetchFromGitHub
, stdenv
, python
, python27
, bash
, cairo
, glib
, gnome3
, gobject-introspection
, gobjectIntrospection
, gstreamer
, gtk3
, lessc
, libcanberra-gtk3
, pkgconfig
}:

stdenv.mkDerivation rec {
  name = "polychromatic-${version}";
  version = "0.3.12";
  
  src = fetchFromGitHub {
    owner = "polychromatic";
    repo = "polychromatic";
    rev = "v${version}";
    sha256 = "11sx2gj463niwr3vrfhgpp84g16k2yyz20f2y4srs8f4lwivbaj0";
  };


  makeFlags = [ "PREFIX=$(out)" ];
  #pathsToLink = [ "/share/man" "/share/doc" "/bin" "/etc" "/usr/lib/python" ];

  preBuild = ''
      patchShebangs .
      substituteInPlace Makefile --replace /etc $out/etc
  '';
  
  buildInputs = [
    cairo
    glib
    gobject-introspection
    gnome3.dconf
    gstreamer
    gtk3
    libcanberra-gtk3
    lessc
  ];

  propogatedBuildInputs = [
    python27.pkgs.setproctitle
  ];
  
  nativeBuildInputs = [
    gobjectIntrospection
    pkgconfig
  ];

  propogatedUserEnvPkgs = [
    gnome3.dconf
  ];

}
