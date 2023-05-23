{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      joshuto
    ];
  };
}
