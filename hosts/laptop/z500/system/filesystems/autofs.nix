{
  #config,
  lib,
  pkgs,
  ...
}:
let
  sambaHost = "192.168.18.51";

  shares = [
    "cipreses"
    "multimedia"
    "code"
    "devices"
    "personal"
    "private"
  ];

  cifsOpts = lib.concatStringsSep "," [
    "iocharset=utf8"
    "cifsacl"

    #"soft"
    #"retry=0"

    "vers=3.1.1"

    #"credentials=${config.sops.secrets.samba-credentials.path}"
    "credentials=/home/vanhyr/.local/.samba/.valentin" # TODO -> change this (use sops)!

    "uid=1000"
    "gid=1000"

    #"file_mode=0660"
    #"dir_mode=0770"

    # TODO -> take a look at this
    #"rsize=4194304"
    #"wsize=4194304"
    #"cache=strict"
  ];

  autoSambaMap = lib.concatMapStringsSep "\n" (
    share: ''${share} -fstype=cifs,${cifsOpts} ://${sambaHost}/${share}''
  ) shares;
in
{
  environment.systemPackages = [
    pkgs.cifs-utils
  ];

  services.autofs = {
    #enable = true;
    enable = false;
    timeout = 60;
    autoMaster = ''
      /data/samba file:/etc/auto.samba --ghost
    '';
  };

  environment.etc."auto.samba".text = autoSambaMap;

  #environment.etc."autofs.conf".text = ''
  #  [ autofs ]
  #  mount_wait = 5
  #  negative_timeout = 30
  #'';
}
