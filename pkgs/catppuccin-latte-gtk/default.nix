{ lib, stdenv, fetchzip, pkgs, ... }:

stdenv.mkDerivation rec {
  pname = "cattpuccin-latte-gtk";
  version = "0.2.7";

  src = fetchzip {
    url =
      "https://github.com/catppuccin/gtk/releases/download/v-0.2.7/Catppuccin-Latte-Green.zip";
    sha256 = "sha256-5jZj/KDkxeMCqVcnu4ZT6bmNjo//o89A3eYHck2VZ70=";
    stripRoot = false;
  };

  propagatedUserEnvPkgs = with pkgs; [
    gnome.gnome-themes-extra
    gtk-engine-murrine
  ];

  installPhase = ''
    mkdir -p $out/share/themes/
    cp -r Catppuccin-Latte-Green $out/share/themes
  '';

  meta = {
    description = "Soothing pastel theme for GTK3";
    homepage = "https://github.com/catppuccin/gtk";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.unix;
    maintainers = [ lib.maintainers.Ruixi-rebirth ];
  };
}
