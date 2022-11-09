{ lib, inputs, nixpkgs, home-manager, nur, user, hyprland, impermanence, ... }:

let
  system = "x86_64-linux"; # System architecture

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
      ./system.nix
      nur.nixosModules.nur
      ../modules/programs/nurpkgs.nix
      hyprland.nixosModules.default
      home-manager.nixosModules.home-manager
      impermanence.nixosModules.impermanence
      {
        environment.persistence."/nix/" = {
          directories = [
            "/etc/NetworkManager/system-connections/"
            "/etc/nixos"
            "/home/aria"
            "/home/jeux"
            "/home/baptiste"
            "/nix/var/nix"
            "/root"
            "/var/lib"
            "/var/log"
            "/tmp"
          ];
        };
      }
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          imports = [ (import ./laptop/home.nix) ];
        };
        nixpkgs = {
          overlays = [
            (final: prev: {
              catppuccin-cursors = prev.callPackage ../overlays/catppuccin-cursors.nix { };
              catppuccin-gtk = prev.callPackage ../overlays/catppuccin-gtk.nix { };
            })
          ];
        };
      }
    ];
  };

}
