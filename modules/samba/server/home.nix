{ config, ... }:
{
  imports = [
    ./default.nix
  ];

  services.samba = {
    nsswins = true;
    settings = {
      global = {
        "hosts allow" = [
          "10.10.0.0/16"
          "localhost"
        ];
        "host deny" = "0.0.0.0/0";
        "map to guest" = "bad user";
        "netbios name" = "nixtoo";
        "server string" = "nixtoo";
        workgroup = "home";
      };
      #"guest account" = "nobody";
    };
    #extraConfig = ''
      #workgroup = home
      #server string = nixtoo
      #netbios name = nixtoo
      #hosts allow = 10.10.0.0/16  localhost 
      #hosts deny = 0.0.0.0/0
      #guest account = nobody
      #map to guest = bad user
    #'';
    shares = {
      private = {
        path = "/data/stores";
        browseable = "yes";
        "read only" = "yes";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "evanjs";
        "force group" = "users";
      };
    };
  };
}
