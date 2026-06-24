{
  pkgs,
  ...
}:
{
  services.tumbler.enable = true; # thumbnails
  environment.systemPackages = [
    pkgs.ffmpegthumbnailer # thumbnails,
  ];
  programs = {
    xfconf.enable = true; # for saving thunar options
    thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-volman

        #tumbler # needed if service activate?

        xfce4-exo # xfce support library, dunno

        #libxfce4ui # newer exo, dunno
        #libxfce4util # newer exo, dunno
      ];
    };
  };
}
