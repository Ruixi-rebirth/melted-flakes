{
  programs = {
    git = {
      enable = true;
      userName = "Ruixi-rebirth";
      userEmail = "ruixirebirth@gmail.com";
      signing = {
        key = "18B9F11F26C894A0D9E3F92BB26EAEB7189F30B4";
        signByDefault = true;
      };
      extraConfig = {
        url = {
          "ssh://git@github.com:Ruixi-rebirth" = {
            insteadOf = "https://github.com/Ruixi-rebirth/";
          };
        };
      };
    };
  };
}
