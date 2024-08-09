{ pkgs, config, username, ... }:

let
    symlinks = import ./symlinks.nix { inherit config username; };
    utils = import ./utils.nix { inherit config username; };
in {
    _module.args = { inherit utils; };

    imports = [
        ./gtk-theme.nix
        ./programs/base.nix
    ];

	home = {
        inherit username;
		homeDirectory = "/home/${username}";

		# If reading in the future, don't change this
		stateVersion = "24.05";

		packages = with pkgs; [
            (nerdfonts.override { fonts = [ "Hermit" ]; })

            clang
            rustup
            gnumake

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
