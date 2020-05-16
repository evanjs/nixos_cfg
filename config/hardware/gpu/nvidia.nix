{ config, pkgs, ... }:
let
  openglPackages = with pkgs; [ libvdpau-va-gl vaapiVdpau nv-codec-headers ];
in
{
  services.xserver = {
    screenSection = ''
      Option "metamodes" "nvidia-auto-select +0+0 { ForceCompositionPipeline = On }"
    '';
    useGlamor = true;
    videoDrivers = [ "nvidia" "vesa" ];
  };

  environment.systemPackages = with pkgs; [
    #python36Packages.tensorflowWithCuda
  ];

  boot.vesa = true;
  hardware = {
    nvidia = {
      modesetting.enable = true;
    };
    opengl = {
      extraPackages32 = openglPackages;
      extraPackages = openglPackages;
    };
  };
}
