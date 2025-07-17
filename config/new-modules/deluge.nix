{ config, lib, pkgs, ... }:

with lib;

{

  options.mine.deluged.enable = mkEnableOption "deluge daemon config";

  config = mkIf config.mine.deluged.enable {

    services.deluge = {
      enable = true;
      openFilesLimit = 8192;
      package = pkgs.deluge-2_x;

      web = {
        enable = true;
        openFirewall = true;
      };
    };


    networking.firewall.allowedTCPPorts = [ 58846 ];



    #users.users = mkMerge (map (user: {
      #${user}.extraGroups = [ "deluge" ];
    #}) config.mine.mainUsers);

    users.users = {
      root.extraGroups = [ "deluge" ];
      evanjs.extraGroups = [ "deluge" ];
      deluge.extraGroups = [ "media" ];
    };


  };

}
