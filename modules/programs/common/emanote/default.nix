{ config, ... }:
{
  services.emanote = {
    enable = true;
    host = "127.0.0.1";
    port = 7000;
    notes = [
      "Flakes/blog" # add as many layers as you like
    ];
  };
}
