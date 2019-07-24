{ config, pkgs, lib, ... }:

with lib;

{
  security.sudo.extraConfig = ''
    evanjs  ALL=(ALL) NOPASSWD: ${pkgs.physlock}/bin/physlock
  '';

  services.xserver.xautolock = rec {
    enable = false;
    enableNotifier = true;
    locker = "${pkgs.physlock}/bin/physlock";
    
    notify = 60;
    notifier = ''
      ${pkgs.libnotify}/bin/notify-send "Locking in ${toString notify} seconds
    '';
  };
}
