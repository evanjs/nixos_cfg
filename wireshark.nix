  { config, pkgs, ... }:
  {
    users.users.evanjs.extraGroups = [ "wireshark" ];
    environment.systemPackages = with pkgs; [
      wireshark
    ];
  }
