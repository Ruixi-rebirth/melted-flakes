{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    twemoji-color-font
  ];
  fonts = {
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      nerdfonts
      twemoji-color-font
    ];
    fontconfig = {
      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
        <fontconfig>
          <!-- Default system-ui fonts -->
          <match target="pattern">
            <test name="family">
              <string>system-ui</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>sans-serif</string>
            </edit>
          </match>

          <!-- Default sans-serif fonts-->
          <match target="pattern">
            <test name="family">
              <string>sans-serif</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>Noto Sans CJK SC</string>
              <string>Noto Sans</string>
              <string>Twemoji</string>
            </edit>
          </match>

          <!-- Default serif fonts-->
          <match target="pattern">
            <test name="family">
              <string>serif</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>Noto Serif CJK SC</string>
              <string>Noto Serif</string>
              <string>Twemoji</string>
            </edit>
          </match>

          <!-- Default monospace fonts-->
          <match target="pattern">
            <test name="family">
              <string>monospace</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>Noto Sans Mono CJK SC</string>
              <string>Symbols Nerd Font</string>
              <string>Twemoji</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>zh-HK</string>
            </test>
            <test name="family">
              <string>Noto Sans CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Sans CJK HK</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>zh-HK</string>
            </test>
            <test name="family">
              <string>Noto Serif CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <!-- not have HK -->
              <string>Noto Serif CJK TC</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>zh-HK</string>
            </test>
            <test name="family">
              <string>Noto Sans Mono CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Sans Mono CJK HK</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>zh-TW</string>
            </test>
            <test name="family">
              <string>Noto Sans CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Sans CJK TC</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>zh-TW</string>
            </test>
            <test name="family">
              <string>Noto Serif CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Serif CJK TC</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>zh-TW</string>
            </test>
            <test name="family">
              <string>Noto Sans Mono CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Sans Mono CJK TC</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>ja</string>
            </test>
            <test name="family">
              <string>Noto Sans CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Sans CJK JP</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
                <string>ja</string>
            </test>
            <test name="family">
              <string>Noto Serif CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Serif CJK JP</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>ja</string>
            </test>
            <test name="family">
              <string>Noto Sans Mono CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Sans Mono CJK JP</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>ko</string>
            </test>
            <test name="family">
              <string>Noto Sans CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Sans CJK KR</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>ko</string>
            </test>
            <test name="family">
              <string>Noto Serif CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Serif CJK KR</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>ko</string>
            </test>
            <test name="family">
              <string>Noto Sans Mono CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Sans Mono CJK KR</string>
            </edit>
          </match>

          <!-- Replace monospace fonts -->
          <match target="pattern">
            <test name="family" compare="contains">
              <string>Source Code</string>
            </test>
            <edit name="family" binding="strong">
              <string>Iosevka Term</string>
            </edit>
          </match>
          <match target="pattern">
            <test name="lang" compare="contains">
              <string>en</string>
            </test>
            <test name="family" compare="contains">
              <string>Noto Sans CJK</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>Noto Sans</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang" compare="contains">
              <string>en</string>
            </test>
            <test name="family" compare="contains">
              <string>Noto Serif CJK</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>Noto Serif</string>
            </edit>
          </match>
        </fontconfig>
      '';
    };
  };

}
