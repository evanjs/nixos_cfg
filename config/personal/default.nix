{ config, lib, pkgs, ... }: {

  imports = [
    ./znc.nix
    ./user.nix
  ];

  time.timeZone = "America/Detroit";

  mine.xUserConfig = {
    services.redshift = {
      latitude = "-85.6";
      longitude = "44.7";
    };
  };

  mine.newsboat = {
    config = ''
      auto-reload yes
      browser "chromium %u"
      bind-key j down
      bind-key k up
      bind-key h quit
      bind-key l open
      bind-key o open-in-browser-and-mark-read
      bind-key O open-all-unread-in-browser-and-mark-read
      reload-time 10
      notify-program "${lib.getBin pkgs.libnotify}/bin/notify-send"
    '';
    urls = [
    ];
  };
}
