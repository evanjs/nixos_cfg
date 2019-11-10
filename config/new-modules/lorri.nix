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
        default = "";
        type = types.str;
        example = "lorri=debug";
        description = "The RUST_LOG level to use when running the lorri daemon";
      };
    };
    config = mkIf cfg.enable {
      environment.systemPackages = [ lorri ];
      mine.userConfig = {
        systemd.user = {
          services.lorri = {
            Unit = {
              Description = "Lorri build daemon";
              Documentation = "https://github.com/target/lorri";
              ConditionUser = "!@system";
              Requires = "lorri.socket";
              After = "lorri.socket";
              RefuseManualStart = true;
            };

            Service = {
              ExecStart = "${lorri}/bin/lorri daemon";
              PrivateTmp = true;
              ProtectSystem = "strict";
              WorkingDirectory = "%h";
              Restart = "on-failure";
              Environment =
                let
                  path = with pkgs; makeSearchPath "bin" [ nix gnutar git mercurial ];
                in
                concatStringsSep " " [
                  "PATH=${path}"
                  "RUST_BACKTRACE=1"
                  "RUST_LOG=\"${cfg.logLevel}\""
                ];
              };
            };

            sockets.lorri = {
              Unit = {
                Description = "Socket for lorri build daemon";
              };

              Socket = {
                ListenStream = "%t/lorri/daemon.socket";
              };

              Install = {
                WantedBy = [ "sockets.target" ];
              };
            };
          };
        };
      };
    }
