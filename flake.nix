{
  description = "My Personal NixOS Configuration";

  inputs =
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
      rust-overlay.url = "github:oxalica/rust-overlay";
      impermanence.url = "github:nix-community/impermanence";
      nur.url = "github:nix-community/NUR";
      hyprpicker.url = "github:hyprwm/hyprpicker";
      hypr-contrib.url = "github:hyprwm/contrib";
      hyprland = {
        url = "github:hyprwm/Hyprland";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };

  outputs = inputs @ { self, nixpkgs, home-manager, nur, hyprland, impermanence, rust-overlay, hyprpicker, hypr-contrib, ... }:
    let
      user = "ruixi";
    in
    {
      nixosConfigurations = (
        # NixOS configurations
        import ./hosts {
          # Imports ./hosts/default.nix
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager nur user hyprland impermanence rust-overlay hypr-contrib hyprpicker;
        }
      );
    };
}
