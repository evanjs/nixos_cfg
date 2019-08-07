  { config, pkgs, ... }:
  {
    programs.wireshark = {
      enable = true;
      package = pkgs.wireshark-qt;
    };

    users.extraUsers.evanjs.extraGroups = [ "wireshark" ];
  }
