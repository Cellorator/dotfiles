{ lib, pkgs, ... }:
{
	home = {
		packages = with pkgs; [
			hello
		];

		username = "admin";
		homeDirectory = "/home/admin";

		# If reading in the future, don't change this
		stateVersion = "24.05";
	};
}
