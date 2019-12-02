{ config, pkgs, ... }:
let
  texlivePackages = (pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-full collection-langjapanese algorithms cm-super;
  });
in
  {
    environment.systemPackages = with pkgs; [
      pandoc
      texlivePackages
      texstudio
    ];
  }
