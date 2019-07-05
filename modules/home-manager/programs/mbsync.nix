{ config, pkgs, ... }:

with config.lib.email;
with config.accounts.email;

let

  mkChannel = acct: local: remote: ''
    Channel ${acct}-${pkgs.lib.strings.toLower local}
    Master :${acct}-remote:"${remote}"
    Slave :${acct}-local:${local}
  '';

  mkChannels = acct: ''
    ${mkChannel acct "Inbox" "INBOX"}
    ${mkChannel acct "All" "[Gmail]/All Mail"}
    ${mkChannel acct "Sent" "[Gmail]/Sent Mail"}
    ${mkChannel acct "Drafts" "[Gmail]/Drafts"}
    ${mkChannel acct "Trash" "[Gmail]/Trash"}
    ${mkChannel acct "Spam" "[Gmail]/Spam"}
  '';
in

{
  programs.mbsync = {
    enable = true;
    extraConfig = ''
      CopyArrivalDate yes
      Create Both
      Expunge Both
      Remove None
      SyncState *
      ${concatAccounts "\n" (i: v: mkChannels v)}
    '';
  };

  services.mbsync = {
    enable = true;
    verbose = false;
    frequency = "*:0/15"; # Every 15m
    preExec = ''
      ${pkgs.coreutils}/bin/mkdir -p ${concatAccounts " " (i: v: "${maildirBasePath}/${v}")}
    '';
  };
}
