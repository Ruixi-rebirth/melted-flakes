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
      backgroundColor = "#3A4353";
      borderColor = "#c0caf5";
      progressColor = "over #3B4252";
      textColor = "#FAF4FC";
      extraConfig = ''
        text-alignment=center
        [urgency=high]
        border-color=#B45C65
      '';
    };
  };
}
