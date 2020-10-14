 { pkgs, nixosConfig }:
{ lib, config, ... }:

with lib;

let

  initEntry = types.submodule {
    options = {
      data = mkOption {
        type = types.lines;
        description = "emacs code to execute";
      };

      before = mkOption {
        type = types.listOf types.str;
        default = [];
        description = "To be done before the given targets";
      };

      after = mkOption {
        type = types.listOf types.str;
        default = [];
        description = "To be done after the given targets";
      };
    };
  };

  dag = (import (import ../nix/sources.nix {}).nur { inherit pkgs; }).repos.rycee.lib.dag;

  # TODO: Handle dag cycle error gracefully
  initFile = pkgs.writeText "init.el" (concatMapStringsSep "\n\n" ({ name, data }:
    "; Section ${name}\n${data}"
    ) ([ {
      name = "pkgs";
      data = ''
        (package-initialize)
      '';
    }] ++ (dag.topoSort config.init).result));

  overrides = self: super: {
    nix-mode = super.nix-mode.overrideAttrs (old: {
      src = (import ../nix/sources.nix {}).nix-mode;
    });
    lsp-ui = super.lsp-ui.overrideAttrs (old: {
      src = (import ../nix/sources.nix {}).lsp-ui;
    });
    lsp-mode = super.lsp-mode.overrideAttrs (old: {
      src = (import ../nix/sources.nix {}).lsp-mode;
    });
    lsp-haskell = super.lsp-haskell.overrideAttrs (old: {
      src = (import ../nix/sources.nix {}).lsp-haskell;
    });
  };

  epkgs = (pkgs.emacsPackagesNgGen pkgs.emacs).overrideScope' overrides;

  emacs = epkgs.emacsWithPackages (_: lib.unique config.packages);

  exec = pkgs.writeScriptBin "myemacs" ''
    #!${pkgs.stdenv.shell}
    exec ${emacs}/bin/emacs -q -l ${initFile} "$@"
  '';

in

{

  imports = map (name: ./modules + "/${name}")
    (builtins.attrNames (builtins.readDir ./modules));

  options = {

    package = mkOption {
      type = types.package;
      default = pkgs.emacs26;
      description = "Emacs package to use";
    };

    packages = mkOption {
      type = types.listOf types.package;
      default = [];
      description = "Emacs packages. Use pkgs.emacsPackagesNg to refer to them";
    };

    init = mkOption {
      type = with types; attrsOf (coercedTo str dag.entryAnywhere initEntry);
      default = dag.empty;
      description = "Init entries";
    };

    initFile = mkOption {
      type = types.path;
      readOnly = true;
      description = "init file";
    };

    emacs = mkOption {
      type = types.package;
      readOnly = true;
      description = "Emacs";
    };

    exec = mkOption {
      type = types.package;
      readOnly = true;
      description = "All-in-one executable";
    };

  };

  config = {

    _module.args = {
      inherit pkgs dag epkgs nixosConfig;
    };

    inherit initFile emacs exec;

  };
}
