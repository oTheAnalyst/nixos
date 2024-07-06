{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    ...
  }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/default/configuration.nix
          ./hosts/default/hardware-configuration.nix
          home-manager.nixosModules.home-manager
          ({config, ...}: {
            environment.etc.nixos.source = "${config.users.users.pretender.home}/nix_conf";
          })
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.pretender = import ./hosts/default/home.nix;
	    home-manager.extraSpecialArgs = {inherit inputs; };
          }
        ];
      };
    };
  };
}
