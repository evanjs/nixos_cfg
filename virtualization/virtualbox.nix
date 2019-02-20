{ config, pkgs, ...}:
{
  virtualisation = {
    virtualbox = {
      host = {
        enable = false;
        enableExtensionPack = true;
      };
    };
    kvmgt.enable = true;
  };
  users.extraUsers.myuser.extraGroups = ["vboxusers"];
}
