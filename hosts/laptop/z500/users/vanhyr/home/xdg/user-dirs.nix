{
  config,
  ...
}:
let
  home = config.home.homeDirectory;
  dataHome = "/data/vanhyr";
  mkLink = path: config.lib.file.mkOutOfStoreSymlink "${dataHome}/${path}";
in
{
  xdg.userDirs = {
    enable = true;
    #createDirectories = true;
    createDirectories = false;
    setSessionVariables = true;

    desktop = "${home}/dsk";
    documents = "${home}/doc";
    projects = "${home}/git";
    download = "${home}/dl";
    music = "${home}/mus";
    pictures = "${home}/img";
    videos = "${home}/vid";
    templates = "${home}/doc";
    publicShare = "${home}/doc";
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
