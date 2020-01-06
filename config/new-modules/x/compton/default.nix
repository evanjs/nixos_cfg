{ pkgs, lib, config, ... }:

with lib;

let

  cfg = config.mine.compton;

  package = pkgs.mine.compton-kawase { nvidia = cfg.nvidia; };

  mkComptonService = { autoStart, variantName, cfg }: recursiveUpdate {

    Unit = {
      Description = "Compton X11 compositor - ${variantName}";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${package}/bin/picom --config ${cfg}";
      Restart = "always";
      RestartSec = 3;
    };

  } (optionalAttrs autoStart {
    Install.WantedBy = [ "graphical-session.target" ];
  });

in

{
  options.mine.compton = {

    enable = mkEnableOption "compton config";

    nvidia = mkEnableOption "nvidia stuff";

    highend = mkEnableOption "use high-end by default";
    package = mkOption {
      description = "The compositor package to use";
      default = package;
      type = types.nullOr types.package;
      example = pkgs.compton;
    };

  };

  config = mkIf cfg.enable {

    mine.xUserConfig = {

      home.packages = [ (cfg.package or package) pkgs.xorg.xwininfo ];

      systemd.user.services = {
        compton-high = recursiveUpdate (mkComptonService {
          variantName = "Highend";
          cfg = ./compton-old.conf;
          autoStart = cfg.highend;
        }) {
          Unit.Conflicts = [ "compton-low.service" "compton-trans.service" ];
        };

        compton-low = recursiveUpdate (mkComptonService {
          variantName = "Lowend";
          cfg = ./compton-low.conf;
          autoStart = ! cfg.highend;
        }) {
          Unit.Conflicts = [ "compton-high.service" "compton-trans.service" ];
        };

        compton-trans = recursiveUpdate (mkComptonService {
          variantName = "Trans";
          cfg = ./compton-trans.conf;
          autoStart = false;
        }) {
          Unit.Conflicts = [ "compton-high.service" "compton-low.service" ];
        };
      };
    };
  };
}
