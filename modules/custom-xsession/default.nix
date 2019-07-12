{ config, pkgs, lib, ... }:
{
  imports = [
    ../virtualgl.nix
  ];


  sound.mediaKeys.enable = true;

  #services.hoogle.packages = hp: with pkgs.haskellPackages; [ ];

  services.xserver = {
    desktopManager.xterm.enable = false;
    displayManager = {
      gdm = {
        enable = true;
      };
      lightdm.enable = false;
    };
    exportConfiguration = true;
      #windowManager = {
        #default = "xmonad";
        #xmonad = {
          #enable = true;
          #enableContribAndExtras = true;
          #extraPackages = hp: with pkgs.haskellPackages; [ ] ++ xmonadHaskellPackages;
        #};
      #};

    };

    services.compton = {
      vSync = true;
    };
  }

