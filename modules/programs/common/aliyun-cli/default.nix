{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      aliyun-cli
    ];
  };
}
