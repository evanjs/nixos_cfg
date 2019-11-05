{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.mine.lorri;
  src = (import ../sources).lorri;
  lorri = (import src { inherit src; });
in
  {
    options.mine.lorri = {
      enable = mkEnableOption "lorri daemon";
      logLevel = mkOption {
        default = null;
        type = types.nullOr types.str;
        example = "lorri=debug";
        description = "The RUST_LOG level to use when running the lorri daemon";
      };
    };
    config = mkIf cfg.enable {
      environment.systemPackages = [ lorri ];
      mine.userConfig = {
        systemd.user.services.lorri = {
          Unit = {
            Description = "Lorri daemon";
            After = [ "network.target" ];
            PartOf = [ "multi-user.target" ];
          };

          Service = (
            mkMerge [
              {
                ExecStart = "${lorri}/bin/lorri daemon";
                Restart = "on-failure";
              }
              (mkIf (cfg.logLevel != null) {
                Environment = "RUST_LOG=${cfg.logLevel}";
              })
            ]
            );

            Install = {
              WantedBy = [ "multi-user.target" ];
            };
          };
        };
      };
    }
