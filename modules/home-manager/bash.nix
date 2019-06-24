{ config, pkgs, ... }:
{
  programs = {
    bash = {
      enable = true;
      historyIgnore =[
        "ls"
        "cd"
        "exit"
        "poweroff"
        "reboot"
      ];
    };
  };
}
