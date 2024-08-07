{ lib, pkgs, config, ... }:

let
	username = "admin";
    symlinks = import ./symlinks.nix;
	# configLink = configFolder: {
	# 	source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/dotfiles/${configFolder}";
	# 	recursive = true;
	# };
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
		];

		preferXdgDirectories = true;

        file = symlinks { inherit config; inherit username; };
	};

	programs = {
		home-manager.enable = true;
	};

    fonts.fontconfig.enable = true;
}
