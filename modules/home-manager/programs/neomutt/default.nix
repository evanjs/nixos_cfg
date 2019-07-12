{ config, pkgs, ... }:

with config.lib.email;
with config.accounts.email;

let
  mkAccountFile = name:
  let
    junk = (if name == "gmail" then "Spam" else (if name == "rjg" then "Junk\\ Email" else "Junk\\ Email"));
    mbox = (if name == "gmail" then "set mbox = +${name}/All" else (if name == "rjg" then "set mbox = +${name}/Inbox" else "set mbox = +${name}/All"));
    record = (if name == "gmail" then "Sent" else (if name == "rjg" then "Sent\\ Items" else "Sent"));
    trash = (if name == "gmail" then "Trash" else (if name == "rjg" then "Deleted\\ Items" else "Trash"));
    hostname = (if name == "gmail" then "gmail.com" else (if name == "rjg" then "outlook.office365.com" else null));
  in
  let acct = builtins.getAttr name accounts; in
  pkgs.writeText "${name}_account" ''
    set from = "${acct.address}"
    set hostname = "${hostname}"
    set sendmail = "${pkgs.msmtp}/bin/msmtp -a ${name} --tls-trust-file=${acct.smtp.tls.certificatesFile}"
    set spoolfile = +${name}/Inbox
    ${mbox}
    set record    = +${name}/${record}
    set postponed = +${name}/Drafts
    set trash     = +${name}/${trash}
    mailboxes $spoolfile $record $postponed $trash $mbox +${name}/${junk}
    macro index,pager m? "<save-message>?<enter>" "Move message to mailbox"
    macro index,pager ma "<save-message>$mbox<enter>" "Move message to archive"
    macro index,pager mi "<save-message>$spoolfile<enter>" "Move message to inbox"
  '';

  mkFolderHook = name: shortcut: ''
      folder-hook =${name}/* source ${mkAccountFile name}
      macro index,pager ${shortcut} "<change-folder>=${name}/Inbox<enter><check-stats>"
      push ${shortcut}
  '';

  mailcap = pkgs.writeText "mailcap" ''
      image/jpg; ${./view_attachment.sh} %s jpg
      image/jpeg; ${./view_attachment.sh} %s jpg
      image/pjpeg; ${./view_attachment.sh} %s jpg
      image/png; ${./view_attachment.sh} %s png
      image/gif; ${./view_attachment.sh} %s gif
      application/pdf; ${./view_attachment.sh} %s pdf
      text/html; ${./view_attachment.sh} %s html
      application/octet-stream; ${./view_attachment.sh} %s "-"
  '';

in

  {
    home = {
      packages = with pkgs; [ neomutt urlview ];
      file.".urlview".text = "COMMAND xdg-open %s";
    };

    xdg.configFile."mutt/muttrc".text = ''
      ${builtins.readFile ./colors}
      ${builtins.readFile ./unbindings}
      ${builtins.readFile ./bindings}
      ${builtins.readFile ./muttrc}
      set history_file = "${config.home.homeDirectory}/.cache/mutt/history"
      set mailcap_path = "${mailcap}"
      set folder = "${maildirBasePath}"
      ${concatAccounts "\n" (i: v: mkFolderHook v "<F${toString i}>")}
    '';
  }
