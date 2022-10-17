{ config, pkgs, lib, inputs, user, ... }:

{
  home = {                                
    packages = with pkgs; [
      catppuccin-gtk
    ];
  };
  gtk= {
    enable = true;
    theme = {
      name = "Catppuccin-Frappe-Pink";
      # package = pkgs.catppuccin-gtk.override { size = "compact"; };
    };
    cursorTheme = {
      name = "Catppuccin-Frappe-Dark-Cursors";
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig={
      gtk-theme-name="Catppuccin";
      gtk-icon-theme-name="Papirus-Dark";
      # gtk-font-name="JetBrainsMono Nerd Font 12";
      gtk-cursor-theme-name="Catppuccin-cursor";
      gtk-cursor-theme-size=0;
      gtk-toolbar-style="GTK_TOOLBAR_BOTH_HORIZ";
      gtk-toolbar-icon-size="GTK_ICON_SIZE_LARGE_TOOLBAR";
      gtk-button-images=0;
      gtk-menu-images=0;
      gtk-enable-event-sounds=1;
      gtk-enable-input-feedback-sounds=1;
      gtk-xft-antialias=1;
      gtk-xft-hinting=1;
      gtk-xft-hintstyle="hintmedium";
      gtk-modules="gail:atk-bridge";
      gtk-xft-rgba="none";
    };
  gtk2.extraConfig = ''
    gtk-theme-name="Catppuccin";
    gtk-icon-theme-name="Papirus-Dark";
    gtk-font-name="JetBrainsMono Nerd Font 12";
    gtk-cursor-theme-name="Catppuccin-cursor";
    gtk-cursor-theme-size=0;
    gtk-toolbar-style="GTK_TOOLBAR_BOTH_HORIZ";
    gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
    gtk-button-images=0
    gtk-menu-images=0
    gtk-enable-event-sounds=1
    gtk-enable-input-feedback-sounds=1
    gtk-xft-antialias=1
    gtk-xft-hinting=1
    gtk-xft-hintstyle="hintmedium"
    gtk-xft-rgba="none"
    gtk-modules="gail:atk-bridge"
  '';
  };
}
