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
      (require 'rust-mode)
      (use-package rustic)

      (setq rustic-lsp-client 'eglot)
      (setq rustic-lsp-server 'rust-analyzer)
      (setq rustic-compile-backtrace 1)
    '';

  };

}
