{
  pkgs,
  config,
  ...
}:
let
  gtk-cursor-theme-name = "Colloid-dark-cursors";
  gtk-cursor-theme-pkg = pkgs.colloid-cursors;
  gtk-cursor-theme-size = 24;
in
{
  home.pointerCursor = {
    enable = true;
    name = gtk-cursor-theme-name;
    package = gtk-cursor-theme-pkg;
    size = gtk-cursor-theme-size;
    x11 = {
      enable = true;
    };
    gtk = {
      enable = true;
    };
  };
}
