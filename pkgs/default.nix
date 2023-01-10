{ pkgs, }:

{
  catppuccin-cursors = pkgs.callPackage ./catppuccin-cursors { };
  catppuccin-frappe-gtk = pkgs.callPackage ./catppuccin-frappe-gtk { };
  catppuccin-latte-gtk = pkgs.callPackage ./catppuccin-latte-gtk { };
  qq = pkgs.callPackage ./qq { };
  # netease-cloud-music-gtk = pkgs.callPackage ./netease-cloud-music-gtk { };
}
