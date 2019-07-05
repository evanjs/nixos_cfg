{ config, pkgs, lib, ... }:
{
  accounts = {
    email = {
      accounts = {
        rjg = {
          realName = "Evan Stoll";
          address = "evan.stoll@rjginc.com";
          passwordCommand = if lib.pathExists ../passwords/rjg then "cat ${../passwords/rjg}" else "";

          imap = {
            host = "outlook.office365.com";
            tls = {
              enable = true;
            };
          };
          imapnotify = {
            enable = true;
          };

          flavor = "plain";
          maildir = {
            path = "rjg";
          };
          mbsync = {
            enable = true;
            create = "both";
            extraConfig = {
              account = {
                AuthMechs = "LOGIN";
              };
            };
          };
          smtp = {
            port = 465;
            host = "smtp.outlook.com";
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
          userName = "evan.stoll@rjginc.com";
        };
      };
    };
  };
}
