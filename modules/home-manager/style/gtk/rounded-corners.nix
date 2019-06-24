{ config, pkgs, ... }:
{

  services.compton = {
    enable = true;
    shadow = true;
  };

  gtk.gtk3.extraCss = ''
    decoration, window, window.background {
      border-radius: 0 0 4px 4px;
    }
  '';
}
