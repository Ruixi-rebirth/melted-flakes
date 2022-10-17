{ config, pkgs, ... }:

{
   programs = {
    yt-dlp={
      enable=true;
      extraConfig = ''
        --ignore-errors
# --no-playlist

# Save in ~/Videos
        -o ~/Videos/%(title)s.%(ext)s

# Prefer 1080p or lower resolutions
        -f bestvideo[ext=mp4][width<2000][height<=1200]+bestaudio[ext=m4a]/bestvideo[ext=webm][width<2000][height<=1200]+bestaudio[ext=webm]/bestvideo[width<2000][height<=1200]+bestaudio/best[width<2000][height<=1200]/best

      '';
    };
  };
}
