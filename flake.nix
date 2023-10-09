{
  description = "My NixOS config for various systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hardware.url = "github:nixos/nixos-hardware";
    sops-nix.url = "github:mic92/sops-nix";

    mailserver.url = "gitlab:simple-nixos-mailserver/nixos-mailserver";

    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;

      lib = nixpkgs.lib // home-manager.lib;

      systems = [ "x86_64-linux" ];
      pkgsFor = nixpkgs.legacyPackages;
      forEachSystem = f: lib.genAttrs systems (sys: f pkgsFor.${sys});
    in {
      inherit lib;

      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home;

      overlays = import ./overlays { inherit inputs outputs; };

      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });

      nixosConfigurations = {
        niyu = lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/niyu ];
        };

        # yuli = lib.nixosSystem {
        #   specialArgs = { inherit inputs outputs; };
        #   modules = [ ./hosts/yuli ];
        # };
        #
        # piyo = lib.nixosSystem {
        #   specialArgs = { inherit inputs outputs; };
        #   modules = [ ./hosts/piyo ];
        # };
      };

      homeConfigurations = {
        "rain@niyu" = lib.homeManagerConfiguration {
          modules = [ ./home/rain/niyu.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };

        # "rain@yuli" = lib.homeManagerConfiguration {
        #   modules = [ ./home/rain/yuli.nix ];
        #   pkgs = pkgsFor.x86_64-linux;
        #   extraSpecialArgs = { inherit inputs outputs; };
        # };
        #
        # "rain@piyo" = lib.homeManagerConfiguration {
        #   modules = [ ./home/rain/piyo.nix ];
        #   pkgs = pkgsFor.x86_64-linux;
        #   extraSpecialArgs = { inherit inputs outputs; };
        # };
      };
    };
}
