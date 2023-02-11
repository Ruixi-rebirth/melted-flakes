let
  common = import ../common;
in
[
  ./imgview
  ./kitty
  ./launcher
  ./notice
  ./mpv
] ++ common
