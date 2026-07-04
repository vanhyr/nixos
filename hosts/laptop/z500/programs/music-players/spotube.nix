{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    spotube
    yt-dlp
  ];
}
