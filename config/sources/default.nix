let
  lib = import <nixpkgs/lib>;
  files = lib.filterAttrs (name: value:
    lib.hasSuffix ".nix" name
    && name != "default.nix"
    && name != "call.nix"
  ) (builtins.readDir ./.);
in
  lib.mapAttrs' (name: value: let
    file = toString ./. + "/${name}";
    _ = lib.traceVal file;
  in {
    name = lib.removeSuffix ".nix" name;
    value = import ./call.nix {
      inherit file;
    };
  }) files
