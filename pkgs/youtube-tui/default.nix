{ stdenv
, lib
, fetchCrate
, rustPlatform
, pkg-config
, libsixel
, libxcb
, gcc
, openssl
, libressl
}:
rustPlatform.buildRustPackage rec {
  pname = "youtube-tui";
  version = "0.7.0";

  src = fetchCrate {
    inherit pname version;
    # url = "https://crates.io/api/v1/crates/youtube-tui/0.7.0/download";
    sha256 = "sha256-Rz13mGqxfCU+6k2Ejvk+ZoaLirDT6VkmAIhvFdNRvuI=";
  };

  # dontUnpack = true;
  # unpackPhase = ''
  #   ${pkgs.p7zip}/bin/7z x $src
  # '';
  # cargoSha256 = "";
  cargoHash = "sha256-qcWuh8qaOQBBebdX3D01k5yXZfifbFC+ZP0d6bJeOr0=";
  # cargoDepsName = pname;
  nativeBuildInputs = [ openssl ];
  buildInputs = [ gcc libsixel libxcb pkg-config ];

  doCheck = false;

  meta = with lib; {
    description = "An aesthetically pleasing YouTube TUI written in Rust";
    homepage = "https://siriusmart.github.io/youtube-tui";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ Ruixi-rebirth ];
  };
}
