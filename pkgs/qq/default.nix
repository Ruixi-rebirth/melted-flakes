{ appimageTools, lib, fetchurl, fetchzip, electron, makeWrapper, libsecret, p7zip }:

let
  pname = "qq";
  version = "3.0.0-565";
  name = "Tencent-QQ-${version}";

  srcs = {
    electron = fetchurl {
      url = "https://dldir1.qq.com/qqfile/qq/QQNT/64bd2578/linuxqq_3.0.0-565_x86_64.AppImage";
      sha256 = "sha256-uoxGwuG+RP1XiNEvQZ5yLHh2rYU1TxBsl9NYaYZ78AI=";
    };
  };

  src = srcs.electron;

  appimageContents = (appimageTools.extract { inherit name src; });

in
appimageTools.wrapAppImage {
  inherit version name;
  src = appimageContents;

  extraInstallCommands = ''
    mv $out/bin/${name} $out/bin/${pname}
    install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}' \
      --replace 'Icon=/opt/QQ/resources/app/512x512.png' 'Icon=qq'
    cp -r ${appimageContents}/usr/share/icons $out/share
  '';

  #passthru.version = version;

  extraPkgs = pkgs: with pkgs; [
    libsecret
    libappindicator-gtk3
  ];

  meta = with lib; {
    homepage = "https://im.qq.com";
    description = "(Deprecated. You should migrate to nixpkgs distribution) Official Tencent QQ client for Linux (Beta)";
    platforms = [ "x86_64-linux" ];
    license = licenses.unfree;
  };
}
