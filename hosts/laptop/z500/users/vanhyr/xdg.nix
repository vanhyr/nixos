{
  config,
  ...
}:
{
  xdg = {
    enable = true;
    binHome = "${config.home.homeDirectory}/.local/bin";
    dataHome = "${config.home.homeDirectory}/.local/share";
    cacheHome = "${config.home.homeDirectory}/.cache";
    stateHome = "${config.home.homeDirectory}/.local/state";
    configHome = "${config.home.homeDirectory}/.config";
    #mime = {
    #  enable = true;
    #};
  };
}
