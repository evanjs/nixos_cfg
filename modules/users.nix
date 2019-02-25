{ config, pkgs, ... }:
{
   # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.evanjs = {
     home = "/home/evanjs";
     extraGroups = [ "wheel" ];
     isNormalUser = true;
     uid = 1000;
   };
 }
