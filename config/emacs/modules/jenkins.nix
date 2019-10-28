{ dag, epkgs, pkgs, lib, config, nixosConfig, ... }:
with lib;
let password = "PASSWORD_STORE_DIR=${nixosConfig.home-manager.users.evanjs.lib.sessionVariables.PASSWORD_STORE_DIR} ${pkgs.pass}/bin/pass rjg/jenkins/emacs | ${pkgs.coreutils}/bin/head -n1";
in
  {

    options.jenkins = mkOption {
      type = types.bool;
      default = false;
      description = "Jenkins stuff";
    };

    config = mkIf config.jenkins {

      packages = with epkgs; [
        groovy-mode
        jenkins
      ];

      init.jenkins = ''
        (use-package jenkins)
        (setq jenkins-api-token "${password}")
        (setq jenkins-url "http://172.16.0.240:8080/jenkins")
        (setq jenkins-username "evan_stoll")
        (setq jenkins-viewname "CoPilot/Evan")
      '';

    };

  }
