{ lib, pkgs, config, epkgs, dag, ... }:

with lib;

{

  options.doom.modeline = mkOption {
    type = types.bool;
    default = true;
    description = "Whether to enable doom-modeline";
  };

  config = mkIf config.doom.modeline {

    packages = with epkgs; [
      circe
      mu4e-alert
      ghub
      doom-modeline
      all-the-icons
    ];

    init.modeline = ''
        (use-package doom-modeline
            :ensure t
            :hook (after-init . doom-modeline-mode))

        ;; icons
        ;; Whether display icons in mode-line or not.
        ;; the default setting disables doom-modeline-icon when (display-graphic-p) is nil
        ;; (defvar doom-modeline-icon (display-graphic-p)
        
        ;; per this blog post http://sodaware.sdf.org/notes/emacs-daemon-doom-modeline-icons/
        ;; only enable icons the first time a window frame is opened
        
        (defun enable-doom-modeline-icons (_frame)
        (setq doom-modeline-icon t))
  
        (add-hook 'after-make-frame-functions 
                  #'enable-doom-modeline-icons)

        ;; Whether display the icon for major mode. It respects `doom-modeline-icon'.
        (setq doom-modeline-major-mode-icon doom-modeline-icon)

        ;; Whether display color icons for `major-mode'. It respects
        ;; `doom-modeline-icon' and `all-the-icons-color-icons'.
        (setq doom-modeline-major-mode-color-icon all-the-icons-color-icons)

        ;; Whether display icons for buffer states. It respects `doom-modeline-icon'.
        (setq doom-modeline-buffer-state-icon t)

        ;; Whether display buffer modification icon. It respects `doom-modeline-icon'
        ;; and `doom-modeline-buffer-state-icon'.
        (setq doom-modeline-buffer-modification-icon t)

        ;; Whether display minor modes in mode-line or not.
        (setq doom-modeline-minor-modes (featurep 'minions))

        ;; Whether display buffer encoding.
        (setq doom-modeline-buffer-encoding t)

        ;; Whether display indentation information.
        (setq doom-modeline-indent-info t)

        ;; The maximum displayed length of the branch name of version control.
        (setq doom-modeline-vcs-max-length 32)

        ;; Whether display GitHub notifications or not. Requires `ghub` package.
        (setq doom-modeline-github t)

        ;; The interval of checking GitHub.
        (setq doom-modeline-github-interval (* 30 60))

        ;; Whether display mu4e notifications or not. Requires `mu4e-alert' package.
        (setq doom-modeline-mu4e t)

        ;; Whether display irc notifications or not. Requires `circe' package.
        (setq doom-modeline-irc t)

        ;; Whether display environment version or not
        (setq doom-modeline-env-version t)
    '';
  };
}
