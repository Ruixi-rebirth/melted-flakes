{ stdenv
, lib
, fetchFromGitHub
, rustPlatform
, pkg-config
,
}:
rustPlatform.buildRustPackage rec {
  pname = "youtube-tui";
  version = "0.7.0";

  src = fetchurl {
    url = "https://crates.io/api/v1/crates/youtube-tui/0.7.0/download";
    hash = "";
  };

  cargoHash = "";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ gcc-libs libsixel libxcb ];

  doCheck = false;

  meta = with lib; {
    description = "An aesthetically pleasing YouTube TUI written in Rust";
    homepage = "https://siriusmart.github.io/youtube-tui";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ Ruixi-rebirth ];
  };
}
