{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    shairplay
    (pkgs.avahi.override {
      withLibdnssdCompat = true;
    })
  ];

  services = {
    avahi = {
      enable = true;
      nssmdns = true;
      publish = {
        addresses = true;
        enable = true;
        userServices = true;
      };
    };
  };
}
