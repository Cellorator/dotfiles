{ lib, config, utils, ... }:

with lib;
let
    cfg = config.windowManager.awesome;
in {
    options.windowManager.awesome.enable = mkEnableOption "Enable awesomewm";

    config = mkIf cfg.enable {
        xsession.windowManager.awesome.enable = true;

        home.file = utils.linkToHome [ ".config/awesome" ];
    };
}
