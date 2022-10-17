{ lib, stdenv, fetchzip, ... }:
  stdenv.mkDerivation rec {
    pname = "cattpuccin-cursors";
    version = "9999";
    src = fetchzip {
        url =
          "https://github.com/Ruixi-rebirth1/Catppuccin-cursor/archive/refs/tags/1.0.zip";
        stripRoot = false;
      };
    installPhase = ''
      mkdir -p $out/share/icons/Catppuccin-Frappe-Dark
      cp -va index.theme cursors $out/share/icons/Catppuccin-Frappe-Dark
    '';
    meta = {
      description = "Soothing pastel mouse cursors";
      homepage = "https://github.com/Ruixi-rebirth/Catppuccin-cursor";
      license = lib.licenses.gpl3;
      platforms = lib.platforms.unix;
      maintainers = [ lib.maintainers.Ruixi-rebirth ];
    };
    s
  }

