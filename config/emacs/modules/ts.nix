{ dag, epkgs, pkgs, lib, config, ... }:

with lib;

{

  options.typescript = mkOption {
    type = types.bool;
    default = false;
    description = "TypeScript dev stuff";
  };

  config = mkIf config.typescript {

    packages = with epkgs; [
      company
      tide
      prettier-js
      angular-snippets
    ];

    init.typescript = ''
      (defun setup-tide-mode ()
        (interactive)
        (tide-setup)
        (flycheck-mode +1)
        ;;(setq flycheck-check-syntax-automatically '(save mode-enabled))
        (eldoc-mode +1)
        (tide-hl-identifier-mode +1)
        (prettier-js-mode))


      ;; aligns annotation to the right hand side
      (setq company-tooltip-align-annotations t)

      ;; formats the buffer before saving
      ;; Note: Can't see this working well until the entire project is formatted properly ...
      ;; (add-hook 'before-save-hook 'tide-format-before-save)

      (add-hook 'typescript-mode-hook #'setup-tide-mode)
    '';
  };

}
