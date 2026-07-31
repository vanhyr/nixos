{
  pkgs,
  ...
}:
let
  #gtk-cursor-theme-pkg = pkgs.colloid-cursors;
  ##gtk-cursor-theme-name = "Colloid-dark-cursors";
  #gtk-cursor-theme-name = "Colloid-cursors";

  gtk-cursor-theme-pkg = pkgs.catppuccin-cursors.mochaBlue;
  gtk-cursor-theme-name = "catppuccin-mocha-blue-cursors";

  gtk-cursor-theme-size = 20;
in
{
  home.pointerCursor = {
    enable = true;
    package = gtk-cursor-theme-pkg;
    name = gtk-cursor-theme-name;
    size = gtk-cursor-theme-size;
    x11 = {
      enable = true;
    };
    gtk = {
      enable = true;
    };
  };
}
