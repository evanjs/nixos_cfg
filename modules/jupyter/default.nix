{ config, pkgs, lib, ... }:
with lib;
{
  networking.firewall.allowedTCPPorts = [ 8888 ];
  users.extraUsers.evanjs.extraGroups = [ "jupyter" ];
  services.jupyter = {
    enable = true;
    password = "'${config.private.passwords.jupyter}'";
    ip = "0.0.0.0";
    kernels = {
      python3 = let
        env = (pkgs.stable.python3.withPackages (pythonPackages: with pythonPackages; [
          ipykernel
          pandas
          scikitlearn
          numpy
          networkx
          altair
          arelle
          graphviz
          loguru
        ]));
      in {
        displayName = "Python 3";
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
