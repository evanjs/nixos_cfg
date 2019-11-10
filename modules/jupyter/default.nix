{ config, pkgs, lib, ... }:
with lib;
{
  networking.firewall.allowedTCPPorts = [ 8888 ];
  services.jupyter = {
    enable = true;
    password = "'PASSWORD_STORE_DIR=${config.home-manager.users.evanjs.lib.sessionVariables.PASSWORD_STORE_DIR} ${pkgs.pass}/bin/pass rig/Jupyter | head -n1'";
    ip = "0.0.0.0";
    kernels = {
      python3 = let
        env = (pkgs.python3.withPackages (pythonPackages: with pythonPackages; [
          ipykernel
          pandas
          scikitlearn
          numpy
          networkx
          altair
        ]));
      in {
        displayName = "Python 3 for machine learning";
        argv = [
          "${env.interpreter}"
          "-m"
          "ipykernel_launcher"
          "-f"
          "{connection_file}"
          ];
          language = "python";
        };
      };
    };
  }
