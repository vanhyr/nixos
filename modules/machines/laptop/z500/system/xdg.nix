{
  #config,
  ...
}:
{
  xdg.userDirs = {
    enable = true;
    #createDirectories = true;
    createDirectories = false;

    desktop = "/home/vanhyr/dsk";
    documents = "/home/vanhyr/doc";
    #projects = "/home/vanhyr/git";
    download = "/home/vanhyr/dl";
    music = "/home/vanhyr/mus";
    pictures = "/home/vanhyr/img";
    videos = "/home/vanhyr/vid";
    templates = "/home/vanhyr/doc";
    publicShare = "/home/vanhyr/doc";

    #desktop = "${config.home.homeDirectory}/dsk";
    #documents = "${config.home.homeDirectory}/doc";
    ##projects = "${config.home.homeDirectory}/git";
    #download = "${config.home.homeDirectory}/dl";
    #music = "${config.home.homeDirectory}/mus";
    #pictures = "${config.home.homeDirectory}/img";
    #videos = "${config.home.homeDirectory}/vid";
    #templates = "${config.home.homeDirectory}/doc";
    #publicShare = "${config.home.homeDirectory}/doc";
  };

  fileSystems = {
    #"${config.home.homeDirectory}/dsk" = {
    "/home/vanhyr/dsk" = {
      device = "/data/vanhyr/dsk";
      fsType = "none";
      options = [
        "bind"
        "nofail"
      ];
    };
    #"${config.home.homeDirectory}/doc" = {
    "/home/vanhyr/doc" = {
      device = "/data/vanhyr/doc";
      fsType = "none";
      options = [
        "bind"
        "nofail"
      ];
    };
    ##"${config.home.homeDirectory}/git" = {
    #"/home/vanhyr/git" = {
    #  device = "/data/vanhyr/git";
    #  fsType = "none";
    #  options = [
    #    "bind"
    #    "nofail"
    #  ];
    #};
    #"${config.home.homeDirectory}/dl" = {
    "/home/vanhyr/dl" = {
      device = "/data/vanhyr/dl";
      fsType = "none";
      options = [
        "bind"
        "nofail"
      ];
    };
    #"${config.home.homeDirectory}/mus" = {
    "/home/vanhyr/mus" = {
      device = "/data/vanhyr/mus";
      fsType = "none";
      options = [
        "bind"
        "nofail"
      ];
    };
    #"${config.home.homeDirectory}/img" = {
    "/home/vanhyr/img" = {
      device = "/data/vanhyr/img";
      fsType = "none";
      options = [
        "bind"
        "nofail"
      ];
    };
    #"${config.home.homeDirectory}/vid" = {
    "/home/vanhyr/vid" = {
      device = "/data/vanhyr/vid";
      fsType = "none";
      options = [
        "bind"
        "nofail"
      ];
    };
  };

  #home.file = {
  #  "${config.home.homeDirectory}/dsk".source = config.lib.file.mkOutOfStoreSymlink "/data/vanhyr/dsk";
  #  "${config.home.homeDirectory}/doc".source = config.lib.file.mkOutOfStoreSymlink "/data/vanhyr/doc";
  #  #"${config.home.homeDirectory}/git".source = config.lib.file.mkOutOfStoreSymlink "/data/vanhyr/git";
  #  "${config.home.homeDirectory}/dl".source = config.lib.file.mkOutOfStoreSymlink "/data/vanhyr/dl";
  #  "${config.home.homeDirectory}/mus".source = config.lib.file.mkOutOfStoreSymlink "/data/vanhyr/mus";
  #  "${config.home.homeDirectory}/img".source = config.lib.file.mkOutOfStoreSymlink "/data/vanhyr/img";
  #  "${config.home.homeDirectory}/vid".source = config.lib.file.mkOutOfStoreSymlink "/data/vanhyr/vid";

  #  "/home/vanhyr/dsk".source = config.lib.file.mkOutOfStoreSymlink "/data/vanhyr/dsk";
  #  "/home/vanhyr/doc".source = config.lib.file.mkOutOfStoreSymlink "/data/vanhyr/doc";
  #  #"/home/vanhyr/git".source = config.lib.file.mkOutOfStoreSymlink "/data/vanhyr/git";
  #  "/home/vanhyr/dl".source = config.lib.file.mkOutOfStoreSymlink "/data/vanhyr/dl";
  #  "/home/vanhyr/mus".source = config.lib.file.mkOutOfStoreSymlink "/data/vanhyr/mus";
  #  "/home/vanhyr/img".source = config.lib.file.mkOutOfStoreSymlink "/data/vanhyr/img";
  #  "/home/vanhyr/vid".source = config.lib.file.mkOutOfStoreSymlink "/data/vanhyr/vid";
  #};
}
