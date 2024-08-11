{ pkgs, utils, ... }:
{
    imports = [
        ./extras.nix
    ];
    config.home.packages = with pkgs; [
        wezterm
        fish
        starship
        pfetch
        bat
        zoxide
        eza
        fzf
        neovim
        xclip

        rofi
        alttab
        picom
    ];

    config.home.file = utils.linkToHome (utils.prepend ".config/" [
        "wezterm"
        "fish"
        "nvim"

        "awesome"
        "rofi"
        "picom"
    ]);
}
