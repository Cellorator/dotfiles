{ pkgs, utils, ...}:
{
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
        "awesome"
        "wezterm"
        "fish"
        "nvim"
        "rofi"
        "picom"
    ]);
}