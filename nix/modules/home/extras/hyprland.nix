{ pkgs, utils, ... }:
{
    home.packages = with pkgs; [
        swaybg
    ];
    home.file = utils.linkToHome [
        ".config/hypr"
    ];
}
