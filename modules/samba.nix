{ config, pkgs, ... }:
{
  services.samba = {
    enable = true;
    configText = ''
        workgroup = RJGTECH.LOCAL
    '';
  };
}
