  { config, pkgs, ... }:
  {
    environment.systemPackages = with pkgs; [
      wireshark-qt
    ];

    users.extraUsers.evanjs.extraGroups = [ "wireshark" ];
    programs.wireshark.enable = true;
  }
