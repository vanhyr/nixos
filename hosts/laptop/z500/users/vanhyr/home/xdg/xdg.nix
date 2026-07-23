{
  config,
  ...
}:
let
  home = config.home.homeDirectory;
in
{
  xdg = {
    enable = true;
    binHome = "${home}/.local/bin";
    dataHome = "${home}/.local/share";
    cacheHome = "${home}/.cache";
    stateHome = "${home}/.local/state";
    configHome = "${home}/.config";
  };
}
