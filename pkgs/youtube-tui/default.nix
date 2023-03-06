{ stdenv
, lib
, fetchurl
, rustPlatform
, pkg-config
, libsixel
, libxcb
, gcc
}:
rustPlatform.buildRustPackage rec {
  pname = "youtube-tui";
  version = "0.7.0";
  cargoLock = {
    lockFile = ./Cargo.lock;
  };

  src = fetchurl {
    url = "https://crates.io/api/v1/crates/youtube-tui/0.7.0/download";
    sha256 = "sha256-SKKlRu8PpTG7c/E3F4r+K2xR0TB0v/NMHT5IZWIO2ik=";
  };

  # cargoSha256 = lib.fakeSha256;

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ gcc libsixel libxcb ];

  doCheck = false;

  meta = with lib; {
    description = "An aesthetically pleasing YouTube TUI written in Rust";
    homepage = "https://siriusmart.github.io/youtube-tui";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ Ruixi-rebirth ];
  };
}
