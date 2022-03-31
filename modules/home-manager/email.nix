{ config, pkgs, lib, ... }:

let

  mkGmailAccount = { name, address, primary ? false }: {
    inherit primary address;
    realName = "Evan Stoll";
    flavor = "gmail.com";
    passwordCommand = "PASSWORD_STORE_DIR=${config.home-manager.users.evanjs.lib.sessionVariables.PASSWORD_STORE_DIR} ${pkgs.pass}/bin/pass email/${name} | ${pkgs.coreutils}/bin/head -n1";
    maildir.path = name;
    smtp.tls.useStartTls = true;
    imap.tls.useStartTls = false;
    msmtp.enable = true;
    mbsync = {
      enable = true;
      create = "both";
      expunge = "both";
      extraConfig.channel = {
        CopyArrivalDate = "yes";
      };
    };
    notmuch.enable = true;
  };

  mkOffice365Account = { name, address, primary ? false }: {
    inherit primary address;
    userName = address;
    realName = "Evan Stoll";
    passwordCommand = "PASSWORD_STORE_DIR=${config.home-manager.users.evanjs.lib.sessionVariables.PASSWORD_STORE_DIR} ${pkgs.pass}/bin/pass email/${name} | ${pkgs.coreutils}/bin/head -n1";
    maildir.path = name;
    smtp = {
      host = "smtp.outlook365.com";
      tls.useStartTls = true;
    };
    imap = {
      host = "outlook.office365.com";
      tls.useStartTls = false;
    };
    msmtp.enable = lib.mkDefault true;
    mbsync = {
      enable = lib.mkDefault true;
      create = "both";
      expunge = "both";
      #patterns = ["![Outlook]*"];
      extraConfig.channel = {
        CopyArrivalDate = "yes";
      };
    };
    notmuch.enable = true;
  };

  accounts = {
    gmail = (mkGmailAccount ({ name = "gmail"; primary = true; address = "evanjsx@gmail.com"; }));
    rjg = (mkOffice365Account ({ name = "rjg"; primary = false; address = "evan.stoll@rjginc.com"; }));
  };

  concatAccounts = separator: fn:
  builtins.concatStringsSep separator
  (pkgs.lib.imap1 fn (builtins.attrNames accounts));
in

  {
    imports = [ ./programs/mbsync.nix ./programs/neomutt ];

    home-manager.users.evanjs = {
      lib.email = { inherit concatAccounts; };

      programs.msmtp.enable = lib.mkDefault true;
      programs.mbsync.enable = lib.mkDefault true;
      programs.notmuch.enable = lib.mkDefault true;

      accounts.email = {
        inherit accounts;
        maildirBasePath = "${config.home-manager.users.evanjs.home.homeDirectory}/mail";
      };
    };
  }
