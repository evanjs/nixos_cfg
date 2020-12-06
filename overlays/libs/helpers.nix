{ lib, ... }:
with lib;
rec {

  # TODO: Improve error-handling/provide error messages that specify the expected inputs for each function, etc

  # attrContainsDrv :: attrs -> string -> listOf Derivation
  attrsContainsDrv = attrs: query: concatStringsSep " " (attrNames (lib.filterAttrs (x: y: lib.strings.hasInfix query (lib.strings.getName x)) attrs));
  
  # attrsListContainsDrv :: [attrs] -> string -> listOf Derivation
  attrsListContainsDrv = attrsList: query: concatStringsSep " " (map (drv: strings.getName drv) (lib.filter (x: lib.strings.hasInfix query (lib.strings.getName x)) attrsList));

  # are we running on a NixOS system?
  isNixOS = builtins.readDir /etc ? NIXOS;

  # find the packages in the given <list> that contain <query> 
  filterListByPackageName = list: query: lib.lists.filter (x: lib.strings.hasInfix query (lib.strings.getName x)) list;

  # find the packages in systemPackages that contain <query>
  #filterSystemPackagesByPackageName = query: filterListByPackageName query environment.systemPackages;
}
