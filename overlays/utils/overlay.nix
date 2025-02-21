# it's utils, not lib, because nixpkgs lib doesn't depend on pkgs

pkgs: pkgsOld:

let
    callUtil = file: import file { inherit pkgs; };
    aard = callUtil ./addAsRuntimeDeps.nix;
in
  {
    inherit aard;
    inherit (aard) addAsRuntimeDeps drvName;
    #inherit aard;
  }
