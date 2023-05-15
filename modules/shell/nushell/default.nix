{ pkgs, ... }:
{
  programs = {
    nushell = {
      enable = true;
      shellAliases = { };
      configFile = {
        source = ./config.nu;
      };
      envFile = {
        # source=
        text = ''

        '';
      };
      extraEnv = "";
      environmentVariables = { };
      extraConfig = ''

      '';

    };
  };
}
