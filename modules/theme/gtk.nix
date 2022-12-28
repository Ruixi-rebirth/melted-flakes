{ config, pkgs, lib, inputs, user, ... }:

{

  home = {
    packages = with pkgs; [
      catppuccin-gtk
    ];
  };
  home.pointerCursor = {
    # package = pkgs.catppuccin-cursors;
    package = pkgs.callPackage ../../pkgs/catppuccin-cursors.nix;
    name = "Catppuccin-Frappe-Dark";
    size = 16;
  };
  home.pointerCursor.gtk.enable = true;
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Frappe-Pink";
      # package = pkgs.catppuccin-gtk.override { size = "compact"; };
      package = pkgs.callPackage ../../pkgs/catppuccin-gtk.nix;
    };
    cursorTheme = {
      name = "Catppuccin-Frappe-Dark";
      package = pkgs.callPackage ../../pkgs/catppuccin-cursors.nix;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
    };
    gtk2.extraConfig = ''
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';
  };
}
