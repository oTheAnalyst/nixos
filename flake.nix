{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
<<<<<<< HEAD
    yazi = {
      url = "github:sxyazi/yazi";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    Vesktop = {
      url = "github:Vencord/Vesktop";
      inputs.nixpkgs.follows = "nixpkgs";
      };
=======
>>>>>>> parent of 17aa700 (added in yazi to flake, this is properly added)
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    ...
  }: {
    nixosConfigurations = {
      faker = nixpkgs.lib.nixosSystem {
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
