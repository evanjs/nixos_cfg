{ config, pkgs, ... }:
{
  services.tautulli = {
    enable = true;
    group = "media";
  };
}
