{
  pkgs,
  config,
  ...
}:
let
  home = config.home.homeDirectory;
  sambaDir = "/data/samba";
  #sambaIP = "valentin@192.168.18.51";

  # Colloid GTK
  #gtk-theme-pkg = pkgs.colloid-gtk-theme;
  #gtk-theme-name = "Colloid-Dark";
  # Colloid GTK Catppuccin Mocha
  #colloid-gtk-theme-catppuccin = pkgs.colloid-gtk-theme.override {
  #  themeVariants = [ "default" ];
  #  colorVariants = [ "standard" ];
  #  sizeVariants = [ "standard" ];
  #  tweaks = [ "catppuccin" ];
  #};
  #colloid-gtk-theme-catppuccin-mocha = colloid-gtk-theme-catppuccin.overrideAttrs (oldAttrs: {
  #  patches = (oldAttrs.patches or [ ]) ++ [
  #    ./patches/colloid-catppuccin-mocha.patch
  #  ];
  #});
  #gtk-theme-pkg = colloid-gtk-theme-catppuccin-mocha;
  #gtk-theme-name = "Colloid-Catppuccin";
  # Cattppuccin GTK
  catppuccin-gtk-theme-mocha = pkgs.catppuccin-gtk.override {
    accents = [ "blue" ];
    size = "standard";
    tweaks = [ "normal" ];
    variant = "mocha";
  };
  gtk-theme-pkg = catppuccin-gtk-theme-mocha;
  gtk-theme-name = "catppuccin-mocha-blue-standard+normal";

  # Colloid Icons
  #gtk-icon-theme-pkg = pkgs.colloid-icon-theme;
  #gtk-icon-theme-name = "Colloid-Dark";
  # Colloid Icons Catppuccin
  colloid-icon-theme-catppuccin = pkgs.colloid-icon-theme.override {
    schemeVariants = [ "catppuccin" ];
    colorVariants = [ "default" ];
  };
  gtk-icon-theme-pkg = colloid-icon-theme-catppuccin;
  gtk-icon-theme-name = "Colloid-Catppuccin-Dark";

  # Colloid cursors
  #gtk-cursor-theme-pkg = pkgs.colloid-cursors;
  ##gtk-cursor-theme-name = "Colloid-dark-cursors";
  #gtk-cursor-theme-name = "Colloid-cursors";
  #gtk-cursor-theme-size = 20;
  # Catppuccin Mocha cursors
  #gtk-cursor-theme-pkg = pkgs.catppuccin-cursors.mochaBlue;
  #gtk-cursor-theme-name = "catppuccin-mocha-blue-cursors";
  #gtk-cursor-theme-size = 20;

  #gtk-font-pkg = pkgs.nerd-fonts.jetbrains-mono;
  #gtk-font-name = "JetBrainsMono Nerd Font";
  #gtk-font-size = 11;
in
{
  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "";
    };
  };
  gtk = {
    enable = true;
    colorScheme = "dark";
    theme = {
      package = gtk-theme-pkg;
      name = gtk-theme-name;
    };
    iconTheme = {
      package = gtk-icon-theme-pkg;
      name = gtk-icon-theme-name;
    };
    #cursorTheme = {
    #  package = gtk-cursor-theme-pkg;
    #  name = gtk-cursor-theme-name;
    #  size = gtk-cursor-theme-size;
    #};
    #font = {
    #  package = gtk-font-pkg;
    #  name = gtk-font-name;
    #  size = gtk-font-size;
    #};
    gtk2 = {
      enable = true;
    };
    gtk3 = {
      enable = true;
      bookmarks = [
        #"computer:/// computer"
        #"file:/// /"
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
        # NAS gvfs
        #"smb://${sambaIP}/cipreses 󰣳 cipreses"
        #"smb://${sambaIP}/code 󰣳 code"
        #"smb://${sambaIP}/devices 󰣳 devices"
        #"smb://${sambaIP}/multimedia 󰣳 multimedia"
        #"smb://${sambaIP}/personal 󰣳 personal"
      ];
      extraConfig = {
        #gtk-application-prefer-dark-theme = 1;
        gtk-decoration-layout = "";
      };
      extraCss = ''
        headerbar button.titlebutton,
        windowcontrols button {
          display: none;
        }
      '';
    };
    gtk4 = {
      enable = true;
      colorScheme = "dark";
      theme = {
        package = gtk-theme-pkg;
        name = gtk-theme-name;
      };
      extraConfig = {
        #gtk-application-prefer-dark-theme = 1;
        gtk-decoration-layout = "";
      };
      extraCss = ''
        headerbar button.titlebutton,
        windowcontrols button {
          display: none;
        }
      '';
    };
  };
}
