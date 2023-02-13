{ config, pkgs, ... }:

{
  home = {
    sessionVariables = {
      DWM = "~/Dwm";
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = "kitty";
      QT_QPA_PLATFORMTHEME = "gtk3";
      XDG_CACHE_HOME = "\${HOME}/.cache";
      XDG_CONFIG_HOME = "\${HOME}/.config";
      XDG_BIN_HOME = "\${HOME}/.local/bin";
      XDG_DATA_HOME = "\${HOME}/.local/share";
    };
    sessionPath = [
      "$HOME/.npm-global/bin"
      "$HOME/.local/bin"
      "$HOME/Codelearning/go/bin"
    ];
  };
}
