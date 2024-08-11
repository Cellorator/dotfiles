{ pkgs, utils, ... }:
{
    imports = [
        ./window-managers
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
    ];

    config.home.file = utils.linkToHome (utils.prepend ".config/" [
        "wezterm"
        "fish"
        "nvim"
    ]);
}
