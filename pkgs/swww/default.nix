{ stdenv
, lib
, fetchFromGitHub
, rustPlatform
, pkg-config
, libxkbcommon
,
}:
rustPlatform.buildRustPackage rec {
  pname = "swww";
  version = "0.7.1";

  src = fetchFromGitHub {
    owner = "Horus645";
    repo = "${pname}";
    rev = "v${version}";
    hash = "sha256-Z90Zwjqcu0hbtJwKPUNV996mtdgX//ZWWm+Dya/JV9A=";
  };

  cargoHash = "sha256-7HYSuwVlAv61u346PmsTnUipDc+HDFySMYgeQCAsBLg=";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ libxkbcommon ];

  doCheck = false;

  meta = with lib; {
    description = "A Solution to your Wayland Wallpaper Woes. ";
    homepage = "https://github.com/Horus645/${pname}";
    license = licenses.gpl3Only;
    platforms = [ "x86_64-linux" ];
  };
}
