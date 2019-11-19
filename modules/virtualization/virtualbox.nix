{ config, pkgs, ...}:
{
  virtualisation = {
    virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = false;
      };
    };
    kvmgt.enable = true;
  };
  users.extraUsers.evanjs.extraGroups = ["vboxusers"];
}
