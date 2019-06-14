{ config, pkgs, ... }:
let
  realName = "Evan Stoll";
  signature = {
    text = ''-- Evan Stoll'';
  };
in
  {
    accounts.email.accounts = {
      gmail = {
        address = "evanjsx@gmail.com";
        flavor = "gmail.com";
        mbsync = {
          enable = true;
          create = "both";
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
  }
