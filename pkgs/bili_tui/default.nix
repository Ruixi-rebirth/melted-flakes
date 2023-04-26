{ lib
, buildGoModule
, fetchFromGitHub
,
}:

buildGoModule rec {
  pname = "bilibili_live_tui";
  version = "4441239";

  src = fetchFromGitHub {
    owner = "yaocccc";
    repo = pname;
    rev = "${version}";
    sha256 = "sha256-th66czpHiLdZRqXVGpxVLh2lrvrjXErniJzuwVNZsP0=";
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
