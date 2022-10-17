{ lib, stdenv, fetchzip, ... }:

stdenv.mkDerivation rec {
  pName = "cattpuccin-cursors";
  version = "9999";

  src = fetchzip {
      url =
        "https://github.com/Ruixi-rebirth/Catppuccin-cursor/archive/refs/tags/1.0.zip";
      sha256 = "w7yv9e9MuZgmCdr/RdDxg2hAeIhb1f82idUj4diI8v8=";
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
}
