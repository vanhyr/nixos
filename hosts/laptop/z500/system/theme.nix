{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    colloid-cursors
    colloid-gtk-theme
    colloid-icon-theme
  ];
}
