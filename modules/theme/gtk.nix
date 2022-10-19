{ config, pkgs, lib, inputs, user, ... }:

{
  home = {                                
    packages = with pkgs; [
      catppuccin-gtk
    ];
  };
  home.pointerCursor = {
      package = pkgs.catppuccin-cursors;
      name = "Catppuccin-Frappe-Dark";
      size = 16;
    };
    home.pointerCursor.gtk.enable = true;
  gtk= {
    enable = flase;
    theme = {
      name = "Catppuccin-Frappe-Pink";
      # package = pkgs.catppuccin-gtk.override { size = "compact"; };
    };
    cursorTheme = {
      name = "Catppuccin-Frappe-Dark";
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
