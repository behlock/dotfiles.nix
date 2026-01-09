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
    packages = {
      x86_64-darwin.default = home-manager.packages.x86_64-darwin.default;
      aarch64-darwin.default = home-manager.packages.aarch64-darwin.default;
      x86_64-linux.default = home-manager.packages.x86_64-linux.default;
      armv7l-linux.default = home-manager.packages.armv7l-linux.default;
    };

    #  Personal Macbook
    homeConfigurations."wbehlock" =
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules = [ ./home-wbehlock.nix ];
      };

    # Mac Mini
    homeConfigurations."behlock" =
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules = [ ./home-behlock.nix ];
      };

    # Work Macbook
    homeConfigurations."wbehlock@Walids-MBP" =
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules = [ ./home-wbehlock.nix ];
      };

    # Raspberry Pi
    homeConfigurations."pi" =
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.armv7l-linux;
        modules = [ ./home-pi.nix ];
      };

    # NVIDIA DGX Spark
    homeConfigurations."behlock@dgx-spark" =
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [ ./home-dgx.nix ];
      };
    };
}