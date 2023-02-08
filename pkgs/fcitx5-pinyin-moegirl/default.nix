{ stdenv
, lib
, fetchurl
}:
stdenv.mkDerivation {
  pname = "fcitx5-pinyin-moegirl";
  version = "20230114";

  src = fetchurl {
    url = "https://github.com/outloudvi/mw2fcitx/releases/download/20230114/moegirl.dict";
    sha256 = "sha256-TpWxm1Jl6WxdAqBo22u5d7xQv/3P04PDMELfQOX7IkQ=";
  };

  dontUnpack = true;
  installPhase = ''
    install -Dm644 $src $out/share/fcitx5/pinyin/dictionaries/moegirl.dict
  '';
  meta = with lib; {
    description = "Fcitx 5 PinyinDictionary from zh.moegirl.org.cn ";
    homepage = "https://github.com/outloudvi/mw2fcitx";
    license = licenses.unlicense;
  };
}
