self: super:
{
  flameshot = super.flameshot.overrideAttrs (old: {
    src = super.fetchFromGitHub {
      owner = "flameshot-org";
      repo = "flameshot";
      rev = "3ededae";
      hash = "sha256-4SMg63MndCctpfoOX3OQ1vPoLP/90l/KGLifyUzYD5g=";
    };
    cmakeFlags = [ "-DUSE_WAYLAND_GRIM=true" ];
  });
}
