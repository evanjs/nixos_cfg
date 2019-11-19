{ config, pkgs, ...}:
{
  virtualisation = {
    virtualbox = {
      host = {
        enable = false;
        enableExtensionPack = false;
      };
    };
    kvmgt.enable = true;
  };
  users.extraUsers.myuser.extraGroups = ["vboxusers"];
}
