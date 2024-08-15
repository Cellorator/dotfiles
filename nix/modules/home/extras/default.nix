{ pkgs, ... }:
{
    imports = [
        ./gtk-theme.nix
        ./wine.nix
        ./pro-audio.nix
        ./hyprland.nix
    ];

    home.packages = with pkgs; [
        clang
        rustup
        gnumake

        firefox
    ];
}
