{ dag, epkgs, pkgs, lib, config, nixosConfig, ... }:

with lib;

let google_api_key= "PASSWORD_STORE_DIR=${nixosConfig.home-manager.users.evanjs.lib.sessionVariables.PASSWORD_STORE_DIR} ${pkgs.pass}/bin/pass api/google | head -n1";
in
{

  options.helm = mkOption {
    type = types.bool;
    default = false;
    description = "Helm-related configurations";
  };

  config = mkIf config.helm {

    packages = with epkgs; [
      helm
      helm-youtube
    ];

    init.helm = ''
        (require 'helm-config)

        ;;start helm-youtube.el
        (autoload 'helm-youtube "helm-youtube" nil t)
        (global-set-key (kbd "C-c y") 'helm-youtube) ;; bind hotkey

        ;; set api-key
        (setq helm-youtube-key "${google_api_key}")

        ;;set default browser for you will use to play videos/default generic
        (setq browse-url-browser-function 'browse-url-generic)
        (setq browse-url-generic-program "eww")
    '';

  };

}
