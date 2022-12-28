{ pkgs ? null }:

{
  catppuccin-cursors = pkgs.callPackage ./catppuccin-cursors.nix { };
  catppuccin-gtk = pkgs.callPackage ./catppuccin-gtk.nix { };
}
