{ config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    chromium
  ];

  nixpkgs.config = {
    chromium = {
      enablePepperFlash = true; # Chromium removed support for Mozilla (NPAPI) plugins so Adobe Flash no longer works
    };
  };

  programs.chromium = {
    extensions = [
      "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1Password X
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
      "gcbommkclmclpchllfjekcdonpmejbdp" # HTTPS Everywhere
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
    ];
  };
}
