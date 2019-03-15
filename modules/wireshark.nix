  { config, pkgs, ... }:
  {
    users.extraUsers.evanjs.extraGroups = [ "wireshark" ];
    programs.wireshark.enable = true;
  }
