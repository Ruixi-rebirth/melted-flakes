
vmess://eyJhZGQiOiJjZG4tY24ubmVrb2Nsb3VkLmNuIiwiYWlkIjoiMCIsImhvc3QiOiIiLCJpZCI6IjYxZDQwNzQzLWNlZmEtMzA4NC1iZGViLTU5ZTA3YTA5OWYxMCIsIm5ldCI6IndzIiwicGF0aCI6Ii9jYXRuZXQiLCJwb3J0IjoiMTkwNTAiLCJwcyI6IkFBLVYycmF5LUpQLU5UVC4wMSIsInNjeSI6ImF1dG8iLCJzbmkiOiIiLCJ0bHMiOiIiLCJ0eXBlIjoiIiwidiI6IjIifQ==
vmess://eyJhZGQiOiJjZG4tY24ubmVrb2Nsb3VkLmNuIiwiYWlkIjoiMCIsImhvc3QiOiIiLCJpZCI6IjYxZDQwNzQzLWNlZmEtMzA4NC1iZGViLTU5ZTA3YTA5OWYxMCIsIm5ldCI6IndzIiwicGF0aCI6Ii9jYXRuZXQiLCJwb3J0IjoiMTkwNDMiLCJwcyI6IkFBLVYycmF5LUNBLVRvcm9udG8iLCJzY3kiOiJhdXRvIiwic25pIjoiIiwidGxzIjoiIiwidHlwZSI6IiIsInYiOiIyIn0=
{
  description = "My Personal NixOS Configuration";

  inputs =                                                                  # All flake references used to build my NixOS setup. These are dependencies.
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";                  # Nix Packages

      home-manager = {                                                      # User Package Management
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nur = {
        url = "github:nix-community/NUR";                                   # NUR Packages
      };
    };

  outputs = inputs @ { self, nixpkgs, home-manager,  nur, ... }:   # Function that tells my flake which to use and what do what to do with the dependencies.
    let                                                                     # Variables that can be used in the config files.
      user = "ruixi";
    in                                                                      # Use above variables in ...
    {
      nixosConfigurations = (                                               # NixOS configurations
        import ./hosts {                                                    # Imports ./hosts/default.nix
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager nur user ;   # Also inherit home-manager so it does not need to be defined here.
        }
      );
    };
}

