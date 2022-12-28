{
  description = "My Personal NixOS Configuration";

  inputs =
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      impermanence = {
        url = "github:nix-community/impermanence";
      };
      nur = {
        url = "github:nix-community/NUR";
      };
      hyprland = {
        url = "github:hyprwm/Hyprland";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };

  outputs = inputs @ { self, nixpkgs, home-manager, nur, hyprland, impermanence, ... }:
    let
      user = "ruixi";
    in
    {
      nixosConfigurations = (
        # NixOS configurations
        import ./hosts {
          # Imports ./hosts/default.nix
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager nur user hyprland impermanence; # Also inherit home-manager so it does not need to be defined here.
        }
      );
    };
}
