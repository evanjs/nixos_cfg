{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.vector = {
    journaldAccess = true;

    settings = {
      # System Logs from Journald
      sources.journald = {
        type = "journald";
        journal_directory = "/var/log/journal";
      };
    };
  };
}
