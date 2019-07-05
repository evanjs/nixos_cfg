{ config, pkgs, lib, ... }:
{
  accounts = {
    email = {
      accounts = {
        gmail = {
          realName = "Evan Stoll";
          address = "evanjsx@gmail.com";
          passwordCommand = if lib.pathExists ../passwords/gmail then "cat ${../passwords/gmail}" else "";
          flavor = "gmail.com";
          maildir = {
            path = "gmail";
          };
          mbsync = {
            enable = true;
            create = "both";
          };
          msmtp = {
            enable = true;
          };
          notmuch = {
            enable = true;
          };
          offlineimap = {
            enable = true;
          };
          primary = true;
          userName = "evanjsx@gmail.com";
        };
      };
    };
  };
}
