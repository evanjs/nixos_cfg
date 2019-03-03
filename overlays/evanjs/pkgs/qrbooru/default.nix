{ stdenv
, fetchgitPrivate
, openssl
, pkgconfig
, makeWrapper
, qtbase
, qtquickcontrols
, qtquickcontrols2
, qtdeclarative
, qtgraphicaleffects
, full
, cmake
, ninja
}:

let
  #qmlPath = qmlLib: "${qmlLib}/${full.qtQmlPrefix}";

  inherit (stdenv) lib;
  
  moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
  pkgs = import <nixpkgs> { overlays = [ moz_overlay ]; };

  rust-qt-binding-generator = (pkgs.libsForQt5.callPackage ../rust-qt-binding-generator { });

  #qml2ImportPath = lib.concatMapStringSep ":" qmlPath [
    #full.bin qtdeclarative qtgraphicaleffects qtquickcontrols qtquickcontrols2 qtbase
  #];

in stdenv.mkDerivation rec {
  pname = "qrbooru";
  version = "0.1.0";

  #src = fetchgitPrivate {
    #url = "git@github.com:evanjs/qrbooru.git";
    #sha256 = "04ppfk1rgs315kmn3npmvknjhw2x0ip70jm42xl8jm3x70v1hm75";
  #};

  src = ~/src/rust/qrbooru;

  nativeBuildInputs = [
    makeWrapper
    openssl.dev
    pkgconfig
    cmake
    pkgs.latest.rustChannels.stable.rust
    pkgs.latest.rustChannels.stable.cargo
    rust-qt-binding-generator
  ];

  #cmakeFlags = "-GNinja";

  #buildInputs = [ qtbase qtquickcontrols qtquickcontrols2 ];
  #buildInputs = [ full ninja ];
  buildInputs = [ full qtdeclarative qtgraphicaleffects qtquickcontrols qtquickcontrols2 qtbase makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin
    cp my_rust_qt_quick_project $out/bin/qrbooru
  '';

  postInstall = ''
    wrapProgram $out/bin/my_rust_qt_quick_project --set QT_PLUGIN_PATH ${qtbase}/${qtbase.qtPluginPrefix}
  '';

}

