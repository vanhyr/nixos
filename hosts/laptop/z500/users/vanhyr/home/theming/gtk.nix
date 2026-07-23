{
  pkgs,
  config,
  ...
}:
let
  home = config.home.homeDirectory;
  sambaDir = "/data/samba";

  gtk-theme-name = "Colloid-Dark";
  gtk-theme-pkg = pkgs.colloid-gtk-theme;

  gtk-icon-theme-name = "Colloid-Dark";
  gtk-icon-theme-pkg = pkgs.colloid-icon-theme;

  gtk-cursor-theme-name = "Colloid-dark-cursors";
  gtk-cursor-theme-pkg = pkgs.colloid-cursors;
  gtk-cursor-theme-size = 24;

  gtk-font-name = "JetBrainsMono Nerd Font";
  gtk-font-pkg = pkgs.nerd-fonts.jetbrains-mono;
  gtk-font-size = 11;
in
{
  gtk = {
    enable = true;
    colorScheme = "dark";
    theme = {
      name = gtk-theme-name;
      package = gtk-theme-pkg;
    };
    iconTheme = {
      name = gtk-icon-theme-name;
      package = gtk-icon-theme-pkg;
    };
    #cursorTheme = {
    #  name = gtk-cursor-theme-name;
    #  package = gtk-cursor-theme-pkg;
    #  size = gtk-cursor-theme-size;
    #};
    font = {
      name = gtk-font-name;
      package = gtk-font-pkg;
      size = gtk-font-size;
    };
    gtk2 = {
      enable = true;
    };
    gtk3 = {
      enable = true;
      bookmarks = [
        #"file://${home}/dsk dsk"
        "file://${home}/dl dl"
        "file://${home}/doc doc"
        "file://${home}/git git"
        "file://${home}/img img"
        "file://${home}/mus mus"
        "file://${home}/vid vid"
        # NAS
        "file://${sambaDir}/cipreses 󰣳 cipreses"
        "file://${sambaDir}/code 󰣳 code"
        "file://${sambaDir}/devices 󰣳 devices"
        "file://${sambaDir}/multimedia 󰣳 multimedia"
        "file://${sambaDir}/personal 󰣳 personal"
      ];
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
    gtk4 = {
      enable = true;
      #extraConfig = {
      #  gtk-application-prefer-dark-theme = 1;
      #};
    };
  };
}
