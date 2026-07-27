{
  pkgs,
  config,
  ...
}:
let
  home = config.home.homeDirectory;
  sambaDir = "/data/samba";
  #sambaIP = "valentin@192.168.18.51";

  #gtk-theme-pkg = pkgs.colloid-gtk-theme;
  #gtk-theme-name = "Colloid-Dark";
  colloid-gtk-theme-catppuccin = pkgs.colloid-gtk-theme.override {
    themeVariants = [ "default" ];
    colorVariants = [ "standard" ];
    sizeVariants = [ "standard" ];
    tweaks = [ "catppuccin" ];
  };
  colloid-gtk-theme-catppuccin-mocha = colloid-gtk-theme-catppuccin.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or [ ]) ++ [
      ./patches/colloid-catppuccin-mocha.patch
    ];
  });
  gtk-theme-pkg = colloid-gtk-theme-catppuccin-mocha;
  gtk-theme-name = "Colloid-Catppuccin";

  #gtk-icon-theme-pkg = pkgs.colloid-icon-theme;
  #gtk-icon-theme-name = "Colloid-Dark";
  colloid-icon-theme-catppuccin = pkgs.colloid-icon-theme.override {
    schemeVariants = [ "catppuccin" ];
    colorVariants = [ "default" ];
  };
  gtk-icon-theme-pkg = colloid-icon-theme-catppuccin;
  gtk-icon-theme-name = "Colloid-Catppuccin-Dark";
  #gtk-icon-theme-name = "Colloid-Catppuccin";

  #gtk-cursor-theme-pkg = pkgs.colloid-cursors;
  ##gtk-cursor-theme-name = "Colloid-dark-cursors";
  #gtk-cursor-theme-name = "Colloid-cursors";
  #gtk-cursor-theme-size = 24;

  gtk-font-pkg = pkgs.nerd-fonts.jetbrains-mono;
  gtk-font-name = "JetBrainsMono Nerd Font";
  gtk-font-size = 11;
in
{
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
    font = {
      package = gtk-font-pkg;
      name = gtk-font-name;
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
        # NAS gvfs
        #"smb://${sambaIP}/cipreses 󰣳 cipreses"
        #"smb://${sambaIP}/code 󰣳 code"
        #"smb://${sambaIP}/devices 󰣳 devices"
        #"smb://${sambaIP}/multimedia 󰣳 multimedia"
        #"smb://${sambaIP}/personal 󰣳 personal"
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
