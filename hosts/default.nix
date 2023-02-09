{ system, self, nixpkgs, inputs, user, ... }:

let
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true; # Allow proprietary software
  };

  lib = nixpkgs.lib;
in
{
  laptop = lib.nixosSystem {
    # Laptop profile
    inherit system;
    specialArgs = { inherit inputs user; };
    modules = [
      ./laptop
      inputs.impermanence.nixosModules.impermanence
      ./system.nix
      inputs.nur.nixosModules.nur
      ../modules/programs/nurpkgs.nix
      inputs.hyprland.nixosModules.default
      inputs.sops-nix.nixosModules.sops
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit user; };
          users.${user} = {
            imports = [
              (import ./laptop/home.nix)
            ] ++ [
              inputs.hyprland.homeManagerModules.default
            ];
          };
        };
        nixpkgs = {
          overlays =
            (import ../overlays)
            ++ [
              self.overlays.default
              inputs.neovim-nightly-overlay.overlay
              inputs.rust-overlay.overlays.default
            ];
        };
      }
    ];
  };

}
