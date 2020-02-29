{ lib
, fetchurl
, appimageTools
}:

let
  pname = "ua-expert";
  name = "${pname}-${version}";
  version = "1.5.1";
  safeVersion = "151";

  # client binary requires a registered account
  # https://www.unified-automation.com/downloads/opc-ua-clients.html
  src = ./UaExpert-1.5.1-331-x86_64.AppImage;

in appimageTools.wrapType2 {
  inherit name src;

}
