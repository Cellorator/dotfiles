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
                modules = [ ./hosts/desktop ];
           };
        };

        homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = inputs // { inherit username; };
            modules = [
                ./home-manager/home.nix
            ];
        };
    };
}
