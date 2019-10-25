{ lib, pkgs, config, epkgs, dag, ... }:

with lib;

{

  options.base = mkOption {
    type = types.bool;
    default = true;
    description = "Whether to enable base";
  };

  config = mkIf config.base {

    packages = with epkgs; [
      better-defaults
      projectile
      #neotree
      #gruvbox-theme
      which-key
      editorconfig
      flycheck
      company
      magit
      smooth-scrolling
      #helm
      system-packages
      systemd
      direnv
      undo-tree

      fd-dired
      dired-ranger
      ripgrep
      org-jira

      all-the-icons
      doom-themes
      xkcd

      use-package
    ];

    init = {
      theme = ''
        (load-theme 'doom-one t)
      '';

      base = dag.entryAfter [ "theme" ] ''
        (require 'package)
        (package-initialize 'noactivate)
        (eval-when-compile
          (require 'use-package))
        (require 'all-the-icons)

        (when (version<= "26.0.50" emacs-version )
          (global-display-line-numbers-mode))

        (setq inhibit-startup-screen t)
        (require 'better-defaults)
        (require 'direnv)
        (editorconfig-mode 1)
        (setq company-minimum-prefix-length 1)
        (setq company-idle-delay 0.1)
        (global-company-mode)
        (require 'recentf)
        (recentf-mode)
        (which-key-mode)
        (let
            ((homepath (concat (getenv "HOME") "/.nix-profile/bin"))
             (systempath "/run/current-system/sw/bin"))
            (setenv "PATH" (concat homepath ":" systempath ":" (getenv "PATH")))
            (add-to-list 'exec-path systempath)
            (add-to-list 'exec-path homepath)
            )
        (setq-default ispell-program-name "${pkgs.hunspellWithDicts [ pkgs.hunspellDicts.en-us ]}/bin/hunspell")
        (add-hook 'text-mode-hook 'flyspell-mode)
        (add-hook 'after-init-hook #'global-flycheck-mode)
        (setenv "NIX_REMOTE" "daemon")
        (setq custom-file (concat (getenv "HOME") "/.emacs.d/custom.el"))
        (load custom-file)
        (global-visual-line-mode)
        (defun gcm-scroll-down ()
          (interactive)
          (scroll-up 1))
        (defun gcm-scroll-up ()
          (interactive)
          (scroll-down 1))
        # Disable shortcuts for now
        # (global-set-key "\C-j" 'gcm-scroll-down)
        # (global-set-key "\C-k" 'gcm-scroll-up)
        (require 'smooth-scrolling)
        (smooth-scrolling-mode 1)
        (setq mouse-wheel-scroll-amount '(5 ((shift) . 1))) ;; one line at a time
        (setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
        (load (concat (getenv "HOME") "/.emacs.d/dinit.el"))
      '';
    };

  };
}
