{ lib, fetchFromGitHub }:

# TODO: Clean up this mess

{ nvidia ? false }:

let
  nixpkgs = fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "f2e631148ab4032891d3fc4606886d5dad7cb207";
    sha256 = "1il7rc6lpk753zll9dr8zbws6spy0pm3nn6d1x7qypvll36v917j";
  };

  pkgs = import nixpkgs { config.allowUnfree = true; };

  # From https://github.com/guibou/nixGL
  #nvidiaVersion = "390.77";
  nvidiaVersion = "430.40";
  nvidiaLibs = (pkgs.linuxPackages.nvidia_x11.override {
    libsOnly = true;
    kernel = null;
  }).overrideAttrs(oldAttrs: rec {
    name = "nvidia-${nvidiaVersion}";
    inherit (oldAttrs) src;
    #src = pkgs.fetchurl {
      #url = "http://download.nvidia.com/XFree86/Linux-x86_64/${nvidiaVersion}/NVIDIA-Linux-x86_64-${nvidiaVersion}.run";
      #sha256 = "1myzhy1mf27dcx0admm3pbbkfdd9p66lw0cq2mz1nwds92gqj07p";
    #};
    useGLVND = 0;
  });

  compton-kawase = pkgs.compton-git.overrideAttrs (old: {

    src = (import ../../sources).compton-kawase;

    nativeBuildInputs = old.nativeBuildInputs ++ [ pkgs.makeWrapper ];

    hardeningDisable = [ "format" ];

    postInstall = if nvidia then ''
      wrapProgram $out/bin/compton \
        --set LD_LIBRARY_PATH "${nvidiaLibs}/lib"
    '' else ''
      wrapProgram $out/bin/compton \
        --set LIBGL_DRIVERS_PATH "${pkgs.mesa_drivers}/lib/dri"
    '';
  });

in compton-kawase
