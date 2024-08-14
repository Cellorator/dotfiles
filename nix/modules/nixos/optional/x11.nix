{
    # Enable the X11 windowing system.
    config.services.xserver = {
        enable = true;
        displayManager.lightdm.enable = true;
        windowManager.awesome.enable = true;
        windowManager.qtile.enable = true;

        # Set keyboard layout
        xkb = {
            layout = "us";
            variant = "";
        };
    };
}
