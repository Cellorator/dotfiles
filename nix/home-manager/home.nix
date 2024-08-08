{ lib, pkgs, config, ... }:

let
	username = "admin";
    symlinks = import ./symlinks.nix;
in {
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
            picom

            (nerdfonts.override { fonts = [ "Hermit" ]; })

            clang

            wine-staging
            reaper
            yabridge
            yabridgectl
            bottles
		];

		preferXdgDirectories = true;

        file = symlinks { inherit config; inherit username; };
	};

	programs = {
		home-manager.enable = true;
	};

    fonts.fontconfig.enable = true;

    nixpkgs.config.allowUnfree = true;
}
