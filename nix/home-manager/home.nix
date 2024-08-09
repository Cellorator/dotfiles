{ pkgs, config, username, ... }:

let
    utils = import ./utils.nix { inherit config username; };
in {
    _module.args = { inherit utils; };

    imports = [
        ./gtk-theme.nix
        ./programs/base.nix
        ./programs/extras.nix
    ];

	home = {
        inherit username;
		homeDirectory = "/home/${username}";

		# If reading in the future, don't change this
		stateVersion = "24.05";

		packages = with pkgs; [
            (nerdfonts.override { fonts = [ "Hermit" ]; })
		];

		preferXdgDirectories = true;

        file = utils.linkToHome [
            "bin"
        ];
	};

	programs = {
		home-manager.enable = true;
	};

    fonts.fontconfig.enable = true;
}
