{ config, pkgs, ... }:
let
  texlivePackages = (pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-medium collection-langjapanese algorithms cm-super;
  });
in
  {
    environment.systemPackages = with pkgs; [
      texlivePackages
      pandoc
    ];
  }
