{
  pkgs,
  ...
}:
{
  services = {
    tumbler.enable = true; # thumbnails
    gvfs = {
      enable = true;
      #package = pkgs.gvfs; # default is gnome.gvfs
    };
  };

  environment.systemPackages = with pkgs; [
    ffmpegthumbnailer # tumbler thumbnails
    #sshfs # not sure

    xfce4-exo # xfce support library, dunno
    #libxfce4ui # newer exo, dunno
    #libxfce4util # newer exo, dunno

    # for file extraction
    #file-roller
    xarchiver
  ];

  programs = {
    xfconf.enable = true; # for saving thunar options

    thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };
}
