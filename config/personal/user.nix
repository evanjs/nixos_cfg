{ lib, config, ... }: {

  options.mine.enableUser = lib.mkEnableOption "evanjs user";

  config = lib.mkIf config.mine.enableUser {
    users.extraUsers.evanjs = {

      uid = 1000;
      description = "Evan Stoll";
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "systemd-journal"
        "input"
      ];
    };

    mine.mainUsers = [ "evanjs" ];

  };
}
