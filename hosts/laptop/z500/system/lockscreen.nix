{
  pkgs,
  ...
}:
{
  programs = {
    # for betterlockscreen
    i3lock = {
      enable = true;
      #package = pkgs.i3lock;
      package = pkgs.i3lock-color;
    };
  };
}
