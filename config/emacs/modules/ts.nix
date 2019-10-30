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
      company-flow
      flow-minor-mode

      js2-mode
      tide
      prettier-js
      ng2-mode
    ];

    init.typescript = ''
      (require 'prettier-js)
      (require 'flow-minor-mode)

      (use-package tide
	:ensure t
	:after (typescript-mode company flycheck)
	:hook ((typescript-mode . tide-setup)
	       (typescript-mode . tide-hl-identifier-mode)
	       (before-save . tide-format-before-save)))

	(setq tide-always-show-documentation t)
	(setq prettier-js-args '(
	  "--trailing-comma" "none"
	  "--parser" "flow"
	  "single-quote" "true"
	))
	(setq tide-completion-detailed t)
	;;(setq tide-tsserver-executable "${pkgs.nodePackages.typescript-language-server}/bin/typescript-language-server")

	(with-eval-after-load 'company
	  (add-to-list 'company-backends 'company-flow))



      ;; aligns annotation to the right hand side
      (setq company-tooltip-align-annotations t)

      ;; formats the buffer before saving
      ;; Note: Can't see this working well until the entire project is formatted properly ...
      ;; (add-hook 'before-save-hook 'tide-format-before-save)

    '';

    init.angular = ''
      (require 'ng2-mode)
      (with-eval-after-load 'typescript-mode (add-hook 'typescript-mode-hook #'lsp))
    '';
  };

}
