{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    polkit
    #polkit_gnome
  ];
  security.polkit = {
    enable = true;
    package = pkgs.polkit;
    #package = pkgs.polkit-gnome;
  };
}
