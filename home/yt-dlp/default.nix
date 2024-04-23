{ ... }:
{
  programs.yt-dlp = {
    enable = true;

    extraConfig = ''
      -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best"
      -P ~/Videos/yt-dlp
    '';
  };
}