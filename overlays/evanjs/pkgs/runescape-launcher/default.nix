{ stdenv
, curl
, fetchurl
, lib
, libpng12
, autoPatchelfHook
, makeWrapper 
, gdk_pixbuf
, glib
, xlibs
, expat
, cairo
, pango
, zlib
, gtk2-x11
, libXxf86vm
}:
let
  curlWithGnuTls = curl.override { gnutlsSupport = true; sslSupport = false; };
in
stdenv.mkDerivation rec {
  name = "runescape-launcher";
  version = "2.2.4";

  pathsToLink = [ "/share" "/bin" ];
  extraOutputsToInstall = [ "man" "doc" ];


  unpackCmd = ''
    ar p "$src" data.tar.xz | tar xJ
  '';

  installPhase = ''
    mkdir $out/
    cp -R usr/share usr/bin $out/
    patchShebangs $out/bin/runescape-launcher
    substituteInPlace $out/bin/runescape-launcher --replace /usr/share/games/ $out/share/games/
  '';

  xlibPkgs = with xlibs; [
    libX11
    libSM
  ];

  buildInputs = [
    glib
    libpng12
    expat
    zlib
    cairo
    pango
    gtk2-x11
    curlWithGnuTls
    libXxf86vm
  ]
  ++ xlibPkgs
  ;

  configurePhase = ":";
  buildPhase = ":";


  
  nativeBuildInputs = [ autoPatchelfHook ];
  #builder = ./builder.sh;
  src = fetchurl {
    url = "http://content.runescape.com/downloads/ubuntu/pool/non-free/r/runescape-launcher/runescape-launcher_${version}_amd64.deb";
    sha256 = "14y6rj3rcrxpzlavsnw20kqckmgyikjsd92j3mqvlmn70f2i07pz";
  };
  sourceRoot = ".";
}
