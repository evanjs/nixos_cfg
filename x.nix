{ config, pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    arandr
    #(xmonad-with-packages.override {
      #packages = self: with self; [
        #taffybar
        #xmonad-contrib
        #xmonad-extras
        #xmobar
      #];
    #})
    (haskellPackages.ghcWithPackages (self: with self; [
      mtl
      xmonad
      xmonad-contrib
      xmonad-extras
      xmobar
      taffybar
      cabal-install
      lens
      curl
    ]))
  ];
  services.xserver = {
    enable = true;
    libinput = {
      enable = true;
      tapping = true;
    };


    desktopManager.xterm.enable = false;
    videoDrivers = [ "intel" ];
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
    windowManager.default = "xmonad";
  };
}
