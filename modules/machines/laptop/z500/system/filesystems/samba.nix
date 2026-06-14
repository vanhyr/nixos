{
  pkgs,
  ...
}:
{
  services.gvfs.enable = true;

  environment.systemPackages = [
    pkgs.cifs-utils
  ];

  fileSystems = {
    "/data/samba/cipreses" = {
      device = "//192.168.18.51/cipreses";
      fsType = "cifs";
      options = [
        "_netdev"
        "iocharset=utf8"
        "cifsacl"
        "noauto"
        "x-systemd.automount"
        "x-systemd.idle-timeout=60"
        "x-systemd.mount-timeout=5"
        "credentials=/home/vanhyr/.local/.samba/.valentin" # TODO -> change this (use sops)!
        "uid=1000"
        "gid=1000"
        #"file_mode=0660"
        #"dir_mode=0770"
      ];
      noCheck = true;
    };
    "/data/samba/multimedia" = {
      device = "//192.168.18.51/multimedia";
      fsType = "cifs";
      options = [
        "_netdev"
        "iocharset=utf8"
        "cifsacl"
        "noauto"
        "x-systemd.automount"
        "x-systemd.idle-timeout=60"
        "x-systemd.mount-timeout=5"
        "credentials=/home/vanhyr/.local/.samba/.valentin" # TODO -> change this (use sops)!
        "uid=1000"
        "gid=1000"
        #"file_mode=0660"
        #"dir_mode=0770"
      ];
      noCheck = true;
    };
    "/data/samba/code" = {
      device = "//192.168.18.51/code";
      fsType = "cifs";
      options = [
        "_netdev"
        "iocharset=utf8"
        "cifsacl"
        "noauto"
        "x-systemd.automount"
        "x-systemd.idle-timeout=60"
        "x-systemd.mount-timeout=5"
        "credentials=/home/vanhyr/.local/.samba/.valentin" # TODO -> change this (use sops)!
        "uid=1000"
        "gid=1000"
        #"file_mode=0660"
        #"dir_mode=0770"
      ];
      noCheck = true;
    };
    "/data/samba/devices" = {
      device = "//192.168.18.51/devices";
      fsType = "cifs";
      options = [
        "_netdev"
        "iocharset=utf8"
        "cifsacl"
        "noauto"
        "x-systemd.automount"
        "x-systemd.idle-timeout=60"
        "x-systemd.mount-timeout=5"
        "credentials=/home/vanhyr/.local/.samba/.valentin" # TODO -> change this (use sops)!
        "uid=1000"
        "gid=1000"
        #"file_mode=0660"
        #"dir_mode=0770"
      ];
      noCheck = true;
    };
    "/data/samba/personal" = {
      device = "//192.168.18.51/personal";
      fsType = "cifs";
      options = [
        "_netdev"
        "iocharset=utf8"
        "cifsacl"
        "noauto"
        "x-systemd.automount"
        "x-systemd.idle-timeout=60"
        "x-systemd.mount-timeout=5"
        "credentials=/home/vanhyr/.local/.samba/.valentin" # TODO -> change this (use sops)!
        "uid=1000"
        "gid=1000"
        #"file_mode=0660"
        #"dir_mode=0770"
      ];
      noCheck = true;
    };
    "/data/samba/private" = {
      device = "//192.168.18.51/private";
      fsType = "cifs";
      options = [
        "_netdev"
        "iocharset=utf8"
        "cifsacl"
        "noauto"
        "x-systemd.automount"
        "x-systemd.idle-timeout=60"
        "x-systemd.mount-timeout=5"
        "credentials=/home/vanhyr/.local/.samba/.valentin" # TODO -> change this (use sops)!
        "uid=1000"
        "gid=1000"
        #"file_mode=0660"
        #"dir_mode=0770"
      ];
      noCheck = true;
    };
  };
}
