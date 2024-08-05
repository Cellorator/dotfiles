{ lib, pkgs, config, ... }: let
	username = "admin";
	configLink = configFolder: {
		source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/dotfiles/${configFolder}";
		recursive = true;
	};
in {
	home = {
		username = "admin";
		homeDirectory = "/home/admin";

		# If reading in the future, don't change this
		stateVersion = "24.05";

		packages = with pkgs; [
			fish
			bat
			zoxide
            eza

			wezterm
			neovim

            rofi
            picom
		];

		preferXdgDirectories = true;

		file = {
			"bin" = configLink "bin";
			".config/nvim" = configLink ".config/nvim";
			# ".config/fish" = configLink ".config/fish";
			".config/wezterm" = configLink ".config/wezterm";
			".config/awesome" = configLink ".config/awesome";
			".config/picom" = configLink ".config/picom";
			".config/bat" = configLink ".config/bat";
		};
	};

	programs = {
        fish.enable = true;
		home-manager.enable = true;
	};
}
