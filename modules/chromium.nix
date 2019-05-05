{ config, ...}:
{
  programs.chromium = {
    extensions = [
      "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1Password X
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
      "gcbommkclmclpchllfjekcdonpmejbdp" # HTTPS Everywhere
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
    ];
  };
}
