{ pkgs, utils, ... }:
{
    imports = [
        ./awesome.nix
    ];

    config.home = {
        packages = with pkgs; [
            rofi
            alttab
            picom
        ];
        file = with utils; linkToHome (prepend ".config/" [
            "rofi"
            "picom"
        ]);
    };
}
