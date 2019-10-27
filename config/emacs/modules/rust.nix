{ dag, epkgs, pkgs, lib, config, ... }:

with lib;

{

  options.rust = mkOption {
    type = types.bool;
    default = false;
    description = "Rust dev stuff";
  };

  config = mkIf config.rust {

    lsp = true;

    packages = with epkgs; [
      cargo
      rust-mode
      rustic  #TODO: Try out with rust-analyzer
      eglot
      rust-auto-use
    ];

    init.rust = ''
      (use-package rust-mode)
      (use-package rustic)

      ;; TODO direnv keeps complaining about the various temp folders that direnv+cargo seem to create not existing
      ;; 1) What creates these?
      ;; 2a) Can we ignore the errors?
      ;; 2b) Can we ensure these folders are either created normally when editing Rust files in emacs?
      ;; 2c) Can we prevent these folders from being created, if it doesn't affect my current workflow? (direnv+cargo)

      (setq rustic-lsp-client 'eglot)
      (setq rustic-lsp-server 'rust-analyzer)
      (setq rustic-compile-backtrace 1)
    '';

  };

}
