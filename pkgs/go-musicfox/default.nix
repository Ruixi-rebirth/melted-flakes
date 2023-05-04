{ lib
, buildGoModule
, fetchFromGitHub
, pkg-config
, alsa-lib
, flac
}:

buildGoModule rec {
  pname = "go-musicfox";
  version = import ./version.nix;

  src = fetchFromGitHub {
    owner = "go-musicfox";
    repo = pname;
    rev = "v${version}";
    sha256 = import ./source-sha.nix;
  };

  deleteVendor = true;

  vendorSha256 = import ./vendor-sha.nix;

  subPackages = [ "cmd/musicfox.go" ];

  ldflags = [
    "-s"
    "-w"
    "-X github.com/go-musicfox/go-musicfox/pkg/constants.AppVersion=${version}"
  ];

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    alsa-lib
    flac
  ];

  passthru.updateScript = ./update.sh;

  meta = with lib; {
    description = "Terminal netease cloud music client written in Go";
    homepage = "https://github.com/anhoder/go-musicfox";
    license = licenses.mit;
    mainProgram = "musicfox";
    maintainers = with maintainers; [ zendo Ruixi-rebirth aleksana ];
  };
}
