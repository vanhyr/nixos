{
  config,
  ...
}:
let
  dataHome = "/data/vanhyr";
  mkLink = path: config.lib.file.mkOutOfStoreSymlink "${dataHome}/${path}";
in
{
  xdg.userDirs = {
    enable = true;
    #createDirectories = true;
    createDirectories = false;
    setSessionVariables = true;

    desktop = "${config.home.homeDirectory}/dsk";
    documents = "${config.home.homeDirectory}/doc";
    projects = "${config.home.homeDirectory}/git";
    download = "${config.home.homeDirectory}/dl";
    music = "${config.home.homeDirectory}/mus";
    pictures = "${config.home.homeDirectory}/img";
    videos = "${config.home.homeDirectory}/vid";
    templates = "${config.home.homeDirectory}/doc";
    publicShare = "${config.home.homeDirectory}/doc";
  };

  home.file = {
    "dsk".source = mkLink "dsk";
    "doc".source = mkLink "doc";
    "git".source = mkLink "git";
    "dl".source = mkLink "dl";
    "mus".source = mkLink "mus";
    "img".source = mkLink "img";
    "vid".source = mkLink "vid";
  };
}
