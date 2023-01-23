{
  clangStdenv,
  lib,
  fetchFromGitHub,
  buildGoModule,
  pkg-config,
  alsa-lib,
  flac,
}:

buildGoModule.override { stdenv = clangStdenv; } rec {
  pname = "go-musicfox";
  version = "3.6.1";

  src = fetchFromGitHub {
    owner = "anhoder";
    repo = "go-musicfox";
    rev = "870b9e1ff05831ecbf3741506b95e4abaef7dcca";
    hash = "sha256-EDgw0QfW1E/u0J9tEWeRt6i/rRBeX2jPqtG01YMvWzI=";
  };
   
  vendorHash = "sha256-DbdAEvcspTYMYMvc5IBEUtQAJMW8JZpNi0UA/DvzGFo=";
  
  deleteVendor = true;
  
  nativeBuildInputs = [ pkg-config ];
  
  buildInputs = [ alsa-lib flac ];

  subPackages = [ "cmd/musicfox.go" ];

  doCheck = false;
  
  meta = with lib; {
    description = "Yet another netease music client written in Go. ";
    homepage = "https://github.com/anhoder/${pname}";
    license = licenses.mit;
    platforms = [ "x86_64-linux" ];
  };
}
