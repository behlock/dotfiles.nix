{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nix-index-database, ... }: {
    defaultPackage = {
      x86_64-darwin = home-manager.defaultPackage.x86_64-darwin;
      aarch64-darwin = home-manager.defaultPackage.aarch64-darwin;
      armv7l-linux = home-manager.defaultPackage.armv7l-linux;
    };

    #  Personal Macbook
    homeConfigurations."wbehlock" =
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-darwin;
        modules = [ ./home-wbehlock.nix ];
      };

    # Mac Mini
    homeConfigurations."behlock" =
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules = [ ./home-behlock.nix ];
      };

    # Work Macbook
    homeConfigurations."wbehlock" =
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules = [ ./home-behlock.nix ];
      };

    # Raspberry Pi
    homeConfigurations."pi" =
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.armv7l-linux;
        modules = [ ./home-pi.nix ];
      };
    };
}