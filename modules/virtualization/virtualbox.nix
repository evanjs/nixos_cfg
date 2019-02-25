{ config, pkgs, ...}:
{
  virtualisation = {
    virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = true;
      };
    };
    kvmgt.enable = true;
  };
  users.extraUsers.myuser.extraGroups = ["vboxusers"];
}
