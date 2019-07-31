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
, rustChannel
}:

let
  inherit (stdenv) lib;

  rust-qt-binding-generator = (pkgs.libsForQt5.callPackage ../rust-qt-binding-generator { rustChannel = rustChannel; });

in stdenv.mkDerivation rec {
  pname = "qrbooru";
  version = "0.1.0";

  src = fetchGit {
    url = "git@github.com:evanjs/qrbooru.git";
    rev = "090e3dfff109ec7c302b7e71a50e72d1cda55d0e";
  };

  nativeBuildInputs = [
    makeWrapper
    openssl.dev
    pkgconfig
    cmake
    rustChannel.rust
    rustChannel.cargo
    rust-qt-binding-generator
  ];

  buildInputs = [ full qtdeclarative qtgraphicaleffects qtquickcontrols qtquickcontrols2 qtbase makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin
    cp my_rust_qt_quick_project $out/bin/qrbooru
  '';

  postInstall = ''
    wrapProgram $out/bin/my_rust_qt_quick_project --set QT_PLUGIN_PATH ${qtbase}/${qtbase.qtPluginPrefix}
  '';

}

