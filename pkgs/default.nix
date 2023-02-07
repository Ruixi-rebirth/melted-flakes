final: prev:
{ } // (
  let
    pkgs = prev;
  in
  {
    catppuccin-cursors = pkgs.callPackage ./catppuccin-cursors { };
    catppuccin-frappe-gtk = pkgs.callPackage ./catppuccin-frappe-gtk { };
    catppuccin-latte-gtk = pkgs.callPackage ./catppuccin-latte-gtk { };
    qq = pkgs.callPackage ./qq { };
    go-musicfox = pkgs.callPackage ./go-musicfox { };
    swww = pkgs.callPackage ./swww { };
    fcitx5-pinyin-moegirl = pkgs.callPackage ./fcitx5-pinyin-moegirl { };
  }
)
