{ config, ... }:
{
  imports = [
    ./default.nix
  ];

  services.samba = {
    nsswins = true;
    extraConfig = ''
      workgroup = home
      server string = nixtoo
      netbios name = nixtoo
      hosts allow = 10.10.0.0/16  localhost 
      hosts deny = 0.0.0.0/0
      guest account = nobody
      map to guest = bad user
    '';
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
