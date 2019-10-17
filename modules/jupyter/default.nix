{ config, pkgs, lib, ... }:
with lib;
{
  services.jupyter = {
    enable = true;
    password = readFile ./pass;
  };
}
    ip = "0.0.0.0";
    kernels = {
      python3 = let
        env = (pkgs.python3.withPackages (pythonPackages: with pythonPackages; [
          ipykernel
          pandas
          scikitlearn
          numpy
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
