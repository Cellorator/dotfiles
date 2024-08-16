{
    boot.kernelParams = ["nvidia-drm.modeset=1" "nvidia-drm.fbdev=1" "nvidia.NVreg_UsePageAttributeTable=1"];
    hardware.graphics.enable = true;
    hardware.nvidia = {
        open = true;
        modesetting.enable = true;
        powerManagement.enable = false;
        forceFullCompositionPipeline = true;
    };
    services.xserver.videoDrivers = ["nvidia"];
}
