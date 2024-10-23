{
  description = "qmpwwsd nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Homebrew flakes
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    # Manages configs links things into your home directory
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = {
    nixpkgs,
    nix-darwin,
    home-manager,
    ...
  } @ inputs: 
  # let
  #   inherit (self) outputs;
  # in {
  {
    formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixpkgs-fmt;

    # NixOS configuration entrypoint
    # Available through 'darwin-rebuild --flake .#your-hostname'
    darwinConfigurations = {
      # FIXME replace with your hostname
      qmpwwsd = nix-darwin.lib.darwinSystem {
        specialArgs = inputs;
        # specialArgs = {inherit inputs self;};
	system = "aarch64-darwin";
        # > Our main darwin-nixos configuration file <
        modules = [
	  ./system/configuration.nix
	  home-manager.darwinModules.home-manager 
	  (import ./overlays)
	];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      # FIXME replace with your username@hostname
      "qmpwwsd@qmpwwsd" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs;};
        # > Our main home-manager configuration file <
        modules = [ ./modules/home.nix ];
      };
    };
  };
}
