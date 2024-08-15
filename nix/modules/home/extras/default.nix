{ pkgs, ... }:
{
    imports = [
        ./gtk-theme.nix
    ];

    home.packages = with pkgs; [
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
