import <nixpkgs> {};

pkgs.gitkraken.overrideAttrs (oldAttrs: rec {
  version = "4.2.0";
  src = fetchurl {
    url = "https://release.axocdn.com/linux/GitKraken-v${version}.deb";
    sha256 = "40419f441113b7db128274eeb69ada387a8199544e4a24120a0a0cf4785537e4";
  };
})
