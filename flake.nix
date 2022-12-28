{
  description = "My Personal NixOS Configuration";

  inputs =
    # All flake references used to build my NixOS setup. These are dependencies.
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Nix Packages
      neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
      home-manager = {
        # User Package Management
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      impermanence = {
        url = "github:nix-community/impermanence";
      };
      nur = {
        url = "github:nix-community/NUR"; # NUR Packages
      };
      hyprland = {
        url = "github:hyprwm/Hyprland";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };

  outputs = inputs @ { self, nixpkgs, home-manager, nur, hyprland, impermanence, ... }: # Function that tells my flake which to use and what do what to do with the dependencies.
    let
      # Variables that can be used in the config files.
      user = "ruixi";
    in
    # Use above variables in ...
    {
      nixosConfigurations = (
        # NixOS configurations
        import ./hosts {
          # Imports ./hosts/default.nix
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager nur user hyprland impermanence; # Also inherit home-manager so it does not need to be defined here.
        }
      );
      packages.${system} = {
        catppuccin-gtk = pkgs.callPackage ../pkgs/catppuccin-gtk.nix { };
        catppuccin-cursors = pkgs.callPackage ../pkgs/catppuccin-cursors.nix { };
      };

    };
}
