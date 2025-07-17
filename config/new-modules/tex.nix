{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.mine.tex;
in
  {
    options.mine.tex = rec {
      enable = mkEnableOption "TeX packages and environment";

      # TODO: See if we can break this out more like the below options
      # I was initiailly running into packages not existing or something similar
      #schemePackage = mkOption {
        #description = "The scheme package to provide with the TeX environment";
        #default = pkgs.texlive.scheme-basic;
        #example = pkgs.texlive.scheme-full;
      #};

      #texPackages = mkOption {
        #description = "The packages to be combined with texlive";
        #default = with texlive; [ collection-langjapanese algorithms cm-super schemePackage ];
      #};

      extraPackages = mkOption {
        description = "Additional packages to include with the TeX environment";
        default = with pkgs; [ pandoc texstudio ];
        type = types.listOf types.package;
      };

      #finalPackageSet = mkOption {
        #description = "The final set of TeX packages to include";
        #default = (pkgs.texlive.combine {
          #inherit (pkgs.texlive self.texPackages);
        #});
      #};

      texPackages = mkOption {
        description = "The TeX packages to include in the environment";
        default = (pkgs.texlive.combine {
          inherit (pkgs.texlive) scheme-full collection-langjapanese algorithms cm-super;
        });
        type = types.attrs;
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = [ cfg.texPackages ] ++ cfg.extraPackages;
      #fonts.packages = with pkgs; [
        #noto-fonts-color-emoji
      #];
    };
  }
