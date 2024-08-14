{
    description = "My Home Manager configuration";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { nixpkgs, home-manager, ... }@inputs:
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
        };
    in {
        nixosConfigurations = {
           desktop = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = inputs;
                modules = [
                    hosts/desktop
                    modules/nixos/core/grub.nix
                    modules/nixos/optional/nvidia.nix
                    modules/nixos/optional/pipewire.nix
                    modules/nixos/optional/x11.nix
                ];
           };
        };

        homeConfigurations.admin = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = inputs // { username = "admin"; };
            modules = [
                ./home-manager/home.nix
            ];
        };
    };
}
