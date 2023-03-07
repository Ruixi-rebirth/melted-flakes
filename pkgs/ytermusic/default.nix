{ lib
, rustPlatform
, fetchFromGitHub
  # , pkg-config
  # , openssl
, alsa-lib
, stdenv
, dbus
  # , darwin
  # , libsixel
}:

rustPlatform.buildRustPackage rec {
  pname = "ytermusic";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "ccgauche";
    repo = pname;
    rev = "v${version}";
    hash = "";
  };

  cargoHash = lib.fakeHash;

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    openssl
    dbus
  ];
  # ++ lib.optionals stdenv.isDarwin [
  #   darwin.apple_sdk.frameworks.CoreFoundation
  #   darwin.apple_sdk.frameworks.Security
  # ];

  meta = with lib; {
    description = "A terminal based Youtube Music Player. It's aims to be as fast and simple as possible. Writtten in Rust";
    homepage = "https://github.com/ccgauche/ytermusic";
    license = licenses.asl20;
    maintainers = with maintainers; [ Ruixi-rebirth ];
  };
}
