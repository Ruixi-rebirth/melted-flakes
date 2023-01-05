{ lib
, stdenv
, fetchFromGitHub
, cmake
, libjpeg
, mesa
, pango
, pkg-config
, wayland
, wayland-protocols
, wayland-scanner
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hyprpicker";
  version = "unstable-2022-11-06";

  src = fetchFromGitHub {
    owner = "hyprwm";
    repo = "hyprpicker";
    rev = "ef6009f71c3f18c63207102f18310d62e132a406";
    hash = "sha256-cCBGvS1hI9ZBBhIaz+G/7WSUh+e8tkh5AVosWiq6udc=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
    wayland-scanner
  ];

  buildInputs = [
    libjpeg
    mesa
    pango
    wayland
    wayland-protocols
  ];

  preConfigure = ''
    make protocols
  '';

  installPhase = ''
    runHook preInstall
    install -Dm755 ./hyprpicker -t $out/bin
    runHook postInstall
  '';

  meta = with lib; {
    inherit (finalAttrs.src.meta) homepage;
    description = "A wlroots-compatible Wayland color picker that does not suck";
    license = licenses.bsd3;
    maintainers = with maintainers; [ wozeparrot ];
    inherit (wayland.meta) platforms;
    # ofborg failure: g++ does not recognize '-std=c++23'
    broken = stdenv.isAarch64;
  };
})
