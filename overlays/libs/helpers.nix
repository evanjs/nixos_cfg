{ lib, ... }:
with lib;
{

  # TODO: Improve error-handling/provide error messages that specify the expected inputs for each function, etc

  # attrContainsDrv :: attrs -> string -> listOf Derivation
  attrsContainsDrv = attrs: query: concatStringsSep " " (attrNames (lib.filterAttrs (x: y: lib.strings.hasInfix query (lib.strings.getName x)) attrs));
  
  # attrsListContainsDrv :: [attrs] -> string -> listOf Derivation
  attrsListContainsDrv = attrsList: query: concatStringsSep " " (map (drv: strings.getName drv) (lib.filter (x: lib.strings.hasInfix query (lib.strings.getName x)) attrsList));

  # are we running on a NixOS system?
  isNixOS = builtins.readDir /etc ? NIXOS;
}
