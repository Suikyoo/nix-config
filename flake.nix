{
  description = "config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix/release-26.05";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    nix-firefox-addons.url = "github:osipog/nix-firefox-addons";
    nix-firefox-addons.inputs.nixpkgs.follows = "nixpkgs";
    
    inked-plugin = {
      url = "github:Suikyoo/inked-plugin";
      flake = false;  # plain source, the repo has no flake.nix
    };

    claude-plugins = {
      url = "github:anthropics/claude-plugins-official";
      flake = false;   # it's just a repo of files
    };
    superpower-plugin = {
      url = "github:obra/superpowers";
      flake = false;
      };


  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    stylix,
    ...
  } @ inputs: {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [./nixos/configuration.nix];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "suikyo@nixos" = home-manager.lib.homeManagerConfiguration {
        # Home-manager requires 'pkgs' instance
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # FIXME replace x86_64-linux with your architecture 
        extraSpecialArgs = {inherit inputs;};
        # > Our main home-manager configuration file <
        modules = [
        ./home-manager/home.nix
        stylix.homeModules.stylix
        ];
      };
    };
  };
}
