{ lib
, buildGoModule
, fetchFromGitHub
,
}:

buildGoModule rec {
  pname = "bilibili_live_tui";
  version = "1cc1cee";

  src = fetchFromGitHub {
    owner = "yaocccc";
    repo = pname;
    rev = "${version}";
    sha256 = "sha256-RN2CBSY6TRrOOI7lovuSsV6WirZs2IK+/ZmC6W1/Rcc=";
  };

  vendorSha256 = "sha256-eoLVLAzbw9BxbSgHWxmaxVmlV6RhIscwSAJrv2OpU+k=";
  subPackages = [ "." ];

  ldflags = [
    "-w"
    "-s"
  ];

  meta = with lib; {
    description = "终端下使用的bilibili弹幕获取和弹幕发送服务";
    homepage = "https://github.com/yaocccc/bilibili_live_tui";
    mainProgram = "bili";
    platforms = platforms.linux;
  };
}
