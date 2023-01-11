{ config, pkgs, ... }:

{
  programs = {
    mako = {
      font = "Iosevka Nerd Font 12";
      width = 256;
      height = 500;
      margin = "10";
      padding = "5";
      borderSize = 3;
      borderRadius = 3;
      backgroundColor = "#1a1b26";
      borderColor = "#c0caf5";
      progressColor = "over #302D41";
      textColor = "#c0caf5";
      extraConfig = ''
        text-alignment=center
        [urgency=high]
        border-color=#F8BD96
      '';
    };
  };
}
