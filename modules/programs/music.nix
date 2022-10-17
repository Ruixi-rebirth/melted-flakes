{ config, pkgs, ... }:

{
   home = {
     packages = with pkgs; [
       mpc-cli
       termusic
     ];
   };
   programs = {
    ncmpcpp={
      enable=true;
      mpdMusicDir=null;
    };
   };
   services = {
     mpd={
       enable = true;
       musicDirectory="~/Music";
       extraConfig = ''
         audio_output {
                 type            "pipewire"
                 name            "PipeWire Sound Server"
         }
       '';
   };
  };
}
