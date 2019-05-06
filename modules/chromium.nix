{ config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    chromium
  ];

  programs.chromium = {
    extensions = [
      "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1Password X
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
      "gcbommkclmclpchllfjekcdonpmejbdp" # HTTPS Everywhere
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
    ];
  };
}
