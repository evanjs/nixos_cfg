{ lib, pkgs, config, epkgs, dag, ... }:

with lib;

{

  options.dired = mkOption {
    type = types.bool;
    default = true;
    description = "Whether to enable dired extensions";
  };

  config = mkIf config.dired {

    packages = with epkgs; [
      fd-dired
      dired-git-info
      dired-ranger
    ];

    init.dired = ''
      (with-eval-after-load 'dired
        (define-key dired-mode-map ")" 'dired-git-info-mode))
    '';
  };
}
