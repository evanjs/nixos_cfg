{ stdenv, lib, fetchFromGitHub, autoreconfHook, pkgconfig, gnome3, gtk3, gtk-engine-murrine, gnome-themes-extra }:

let
  pname = "arc-theme-red";

in stdenv.mkDerivation rec {
  name = "${pname}-${version}";
  version = "2017-05-12";

  src = (import ../../nix/sources.nix {}).arc-theme-red;

  nativeBuildInputs = [ autoreconfHook pkgconfig ];

  buildInputs = [ gtk-engine-murrine gtk3 gnome-themes-extra ];

  preferLocalBuild = true;

  configureFlags = [ "--disable-unity" "--with-gnome=3.22" ];

  meta = with lib; {
    description = "A flat theme with transparent elements for GTK 3, GTK 2 and Gnome-Shell";
    homepage    = https://github.com/mclmza/arc-theme-red;
    license     = licenses.gpl3;
    maintainers = with maintainers; [ simonvandel romildo ];
    platforms   = platforms.unix;
  };
}
