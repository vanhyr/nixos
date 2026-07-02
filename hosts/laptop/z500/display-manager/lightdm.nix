{
  ...
}:
{
  services.displayManager = {
    #defaultSession = "";
    lightdm = {
      enable = true;
      greeters.gtk.enable = true;
    };
  };
}
