{
    boot.kernelParams = [ "nvidia-drm.fbdev=1" ];
    hardware.graphics.enable = true;
    hardware.nvidia = {
        open = true;
        modesetting.enable = true;
        nvidiaSettings = true;
        forceFullCompositionPipeline = true;
    };
    services.xserver.videoDrivers = ["nvidia"];
}
