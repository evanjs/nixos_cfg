{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.vector.settings = {
    # Host System Metrics Collection
    sources.host_metrics = {
      type = "host_metrics";
      scrape_interval_secs = 10;
      filesystem = {
        devices.excludes = [
          "nsfs"
          "overlay"
        ];
        mountpoints.excludes = [
          "/mnt/rjg/*"
          "/run/docker/*"
        ];
        excludes = [
          "/mnt/rjg/*"
          "/run/docker/*"
        ];
      };
    };
  };
}
