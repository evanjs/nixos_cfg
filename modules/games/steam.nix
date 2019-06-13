{ config, pkgs, ... }:
{
  
  environment.systemPackages = with pkgs; [
    # TODO: how can this be improved?
    (pkgs.versions.latestVersion [pkgs.steam pkgs.unstable.steam pkgs.unstable-small.steam])
  ];
  
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    pulseaudio.support32Bit = true;
  };
}
