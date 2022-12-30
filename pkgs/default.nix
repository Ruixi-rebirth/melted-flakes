{ pkgs }:

{
  catppuccin-cursors = pkgs.callPackage ./catppuccin-cursors { };
  catppuccin-gtk = pkgs.callPackage ./catppuccin-gtk { };
  qq = pkgs.callPackage ./qq { };
}
