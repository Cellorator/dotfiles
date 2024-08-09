{
    description = "My Home Manager configuration";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { nixpkgs, home-manager, ... }:
        let
            lib = nixpkgs.lib;
            system = "x86_64-linux";
            pkgs = import nixpkgs {
                inherit system;
                config.allowUnfree = true;
            };
            hostname = "nixos";
            username = "admin";
        in {
            nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { inherit hostname username; };
                modules = [ ./nixos/configuration.nix ];
            };

            homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = { inherit username; };
                modules = [ ./home-manager/home.nix ];
            };
        };
}
