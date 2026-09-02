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

  outputs =
    {
      nixpkgs,
      home-manager,
      nix-index-database,
      ...
    }:
    let
      mkHome =
        system: module:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            nix-index-database.homeModules.nix-index
            module
          ];
        };
    in
    {
      packages = {
        x86_64-darwin.default = home-manager.packages.x86_64-darwin.default;
        aarch64-darwin.default = home-manager.packages.aarch64-darwin.default;
        x86_64-linux.default = home-manager.packages.x86_64-linux.default;
        aarch64-linux.default = home-manager.packages.aarch64-linux.default;
        armv7l-linux.default = home-manager.packages.armv7l-linux.default;
      };

      homeConfigurations = {
        # Personal Macbook
        "wbehlock" = mkHome "aarch64-darwin" ./home-wbehlock.nix;
        # Work Macbook
        "wbehlock@Walids-MBP" = mkHome "aarch64-darwin" ./home-wbehlock.nix;
        # Mac Mini
        "behlock" = mkHome "aarch64-darwin" ./home-behlock.nix;
        # Raspberry Pi
        "pi" = mkHome "armv7l-linux" ./home-pi.nix;
        # NVIDIA DGX Spark
        "cookie@dgx-spark" = mkHome "aarch64-linux" ./home-dgx.nix;
      };
    };
}
