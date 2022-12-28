{ config, pkgs, lib, inputs, user, ... }:

{

  home = {
    packages = with pkgs; [
      catppuccin-gtk
    ];
  };
  home.pointerCursor = {
    # package = pkgs.catppuccin-cursors;
    # package = pkgs.catppuccin-cursors;
    package = packages.${pkgs.system}.catppuccin-cursors;
    name = "Catppuccin-Frappe-Dark";
    size = 16;
  };
  home.pointerCursor.gtk.enable = true;
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Frappe-Pink";
      # package = pkgs.catppuccin-gtk.override { size = "compact"; };
      package = packages.${pkgs.system}.catppuccin-gtk;
    };
    cursorTheme = {
      name = "Catppuccin-Frappe-Dark";
      package = packages.${pkgs.system}.catppuccin-cursors;
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
