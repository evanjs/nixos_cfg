{ config, pkgs, ... }:
{
  programs = {
    autorandr ={
      profiles = {
        "work2" = {
          fingerprint = {
            DP-1-3 = "00ffffffffffff005a632edc010101012c1a01030e301b782e84d5a25a52a2260d5054bfef80b300a940a9c095009040818081408100023a801871382d40582c4500dd0c1100001e000000ff005456523136343436303131300a000000fd00324b185213000a202020202020000000fc0056583232353220536572696573009f";
            HDMI-1 = "00ffffffffffff005a632e6f01010101171c010380301b782e84d5a25a52a2260d5054bfef80b300a940a9c095009040818081408100023a801871382d40582c4500dd0c1100001e000000ff005631573138323330333030360a000000fd00324b185211000a202020202020000000fc005641323234362053657269657301e0020324f151900504030207061211131416151e1d1f0123097f078301000065030c001000023a801871382d40582c4500dd0c1100001e011d8018711c1620582c2500dd0c1100009e011d007251d01e206e285500dd0c1100001e8c0ad08a20e02d10103e9600dd0c1100001800000000000000000000000000000000000000c6";
            eDP-1 = "00ffffffffffff0006afec35000000002e1701049522137802bbf5945554902723505400000001010101010101010101010101010101ce1d56c050003030080a310058c11000001ace1d56245100be30080a310058c11000001a000000fe0030464b3244804231353658544e0000000000004121960111000009010a202000db";
          };
          config = {
            DP-1-3 = {
              dpi = 100;
              enable = true;
              mode = "1920x1080";
              position = "0x0";
              rate = "60.00";
            };
            HDMI-1 = {
              dpi = 100;
              enable = true;
              mode = "1920x1080";
              position = "1920x0";
              rate = "60.00";
            };
            eDP-1 = {
              dpi = 118;
              enable = true;
              mode = "1366x768";
              position = "3840x920";
              primary = true;
              rate = "60.02";
            };
          };
        };
      };
    };
  };
}