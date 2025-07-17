{ config, lib, pkgs, ... }: {

  imports = [
    ./znc.nix
    ./user.nix
  ];

  time.timeZone = "America/Detroit";

  mine.xUserConfig = {
    home.stateVersion = "22.05";
    services.redshift = {
      provider = "geoclue2";
      temperature = {
        day = 6000;
        night = 4100;
      };
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
