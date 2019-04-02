{ config, pkgs, ... }:
{
  services.xserver = {
    screenSection = ''
      Option "metamodes" "nvidia-auto-select +0+0 { ForceCompositionPipeline = On }"
    '';
    useGlamor = true;
    videoDrivers = [ "nvidia" ];
  };

  environment.systemPackages = with pkgs; [
    #python36Packages.tensorflowWithCuda
  ];

  hardware = {
    nvidia = {
      modesetting.enable = true;
    };
    opengl = {
      extraPackages = with pkgs; [ vaapiIntel libvdpau-va-gl vaapiVdpau intel-ocl ];
      extraPackages32 = with pkgs; [ vaapiIntel libvdpau-va-gl vaapiVdpau intel-ocl];
    };
  };
}
