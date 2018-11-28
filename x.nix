{ config, pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    arandr
    (xmonad-with-packages.override {
      packages = self: with self; [ taffybar xmonad-contrib xmonad-extras xmobar ];
    })
    haskellPackages.xmobar
    haskellPackages.lens
    haskellPackages.taffybar
  ];
  services.xserver = {
    enable = true;
    libinput = {
      enable = true;
      tapping = true;
    };


    desktopManager.xterm.enable = false;
    videoDrivers = [ "intel" "nvidia" ];
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
    windowManager.default = "xmonad";
  };
}
