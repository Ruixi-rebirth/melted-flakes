{ pkgs, darwin }:

{
  catppuccin-cursors = pkgs.callPackage ./catppuccin-cursors { };
  catppuccin-gtk = pkgs.callPackage ./catppuccin-gtk { };
  qq = pkgs.callPackage ./qq { };
  # netease-cloud-music-gtk = ./pkgs.callPackage ./netease-cloud-music-gtk {
  #   inherit (darwin.apple_sdk.frameworks) Foundation SystemConfiguration;
  # };
}
