{
  ...
}:
let
  gtk-theme-name = "catppuccin-mocha-blue-standard+normal";

  gtk-icon-theme-name = "Colloid-Catppuccin-Dark";

  gtk-cursor-theme-name = "catppuccin-mocha-blue-cursors";
  gtk-cursor-theme-size = 20;
in
{
  #services.xserver.desktopManager.xfce.enable = false;
  services.xsettingsd = {
    enable = true;
    settings = {
      "Net/ThemeName" = gtk-theme-name;
      "Net/IconThemeName" = gtk-icon-theme-name;
      "Gtk/CursorThemeName" = gtk-cursor-theme-name;
      "Gtk/CursorThemeSize" = gtk-cursor-theme-size;
      #"Xft/Antialias" = 1;
      #"Xft/Hinting" = 1;
      #"Xft/HintStyle" = "hintslight";
      #"Xft/RGBA" = "rgb";
      "Gtk/DecorationLayout" = ":";
    };
  };
}
