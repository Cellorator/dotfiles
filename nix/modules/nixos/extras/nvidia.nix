{
    config = {
        hardware = {
            graphics.enable = true;
            nvidia = {
                open = true;
                modesetting.enable = true;
                nvidiaSettings = true;
                forceFullCompositionPipeline = true;
            };
        };
        services.xserver.videoDrivers = ["nvidia"];
    };
}
