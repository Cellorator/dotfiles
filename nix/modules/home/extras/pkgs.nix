{ pkgs, ... }:
{
    config.home.packages = with pkgs; [
        clang
        rustup
        gnumake

        wineWowPackages.staging
        reaper
        yabridge
        yabridgectl
        bottles

        firefox
    ];
}
