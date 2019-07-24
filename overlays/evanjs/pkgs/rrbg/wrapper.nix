{ stdenv, callPackage, buildFHSUserEnv }:

buildFHSUserEnv rec {
  name = "rrbg";

  runScript = "${callPackage ./runtime.nix {}}/bin/rrbg";

  targetPkgs = pkgs: with pkgs // pkgs.xorg; [
    feh
  ];
}
