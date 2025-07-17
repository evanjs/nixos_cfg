{ config, pkgs, lib, ... }:
with lib;
let
  sources = import ../../config/nix/sources.nix;
  #iRust = jupyterWith.kernels.rustWith {
    #packages = with pkgs; [ openssl pkgconfig ];
  #};
  jupyterWith = import sources.jupyterWith {};
  iHaskell = jupyterWith.kernels.iHaskellWith {
    extraIHaskellFlags = "--codemirror Haskell";  # for jupyterlab syntax highlighting
    packages = p: with p; [
      formatting Frames vector aeson hvega pandoc_3_6
      (pkgs.haskell.lib.markUnbroken ihaskell-hvega)
    ];
  };
  iPython = jupyterWith.kernels.iPythonWith {
    packages = p: with p; [
      ipykernel
      pandas
      scikitlearn
      numpy
      networkx
      altair
      arelle
      graphviz
      loguru
    ];
  };
  #lab = jupyterWith.jupyterlabWith {
    #kernels = [
      #iPython
      ##iRust
      #iHaskell
    #];
  #};
  jupyterPort = 8888;
in
  {
    networking.firewall.allowedTCPPorts = [ jupyterPort ];
    users.extraUsers.evanjs.extraGroups = [ "jupyter" ];
    #users.extraUsers.jupyter.isNormalUser = true;
    services.jupyter = {
      notebookConfig = ''
        c.Application.log_level = 'DEBUG'
      '';
      enable = true;
      password = "'${config.private.passwords.jupyter}'";
      #package = lab;
      #command = "jupyter-lab";
      ip = "0.0.0.0";
      port = jupyterPort;
    };
  }
