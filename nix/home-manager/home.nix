{ lib, pkgs, config, ... }:

let
	username = "admin";
    symlinks = import ./symlinks.nix { inherit config; inherit username; };
    utils = import ./utils.nix { inherit config; inherit username; };
in {
    imports = [
        (import ./gtk-theme.nix { inherit utils; })
    ];

	home = {
        inherit username;
		homeDirectory = "/home/${username}";

		# If reading in the future, don't change this
		stateVersion = "24.05";

		packages = with pkgs; [
			fish
            starship
            pfetch
			bat
			zoxide
            eza
            fzf

			wezterm
			neovim

            xclip
            rofi
            alttab
            picom

            (nerdfonts.override { fonts = [ "Hermit" ]; })

            clang

            wineWowPackages.staging
            reaper
            yabridge
            yabridgectl
            bottles

		];

		preferXdgDirectories = true;

        file = symlinks;
	};

	programs = {
		home-manager.enable = true;
	};

    fonts.fontconfig.enable = true;
}
