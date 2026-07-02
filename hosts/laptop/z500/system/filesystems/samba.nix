{
  #config,
  lib,
  pkgs,
  ...
}:
let
  # 1. Centralización de los recursos compartidos Samba
  shares = [
    "cipreses"
    "multimedia"
    "code"
    "devices"
    "personal"
    "private"
  ];

  # 2. Plantilla única de opciones compartidas y optimizadas
  sambaOptions = [
    "_netdev"
    "iocharset=utf8"
    "cifsacl"
    "noauto"
    "x-systemd.automount"
    "x-systemd.idle-timeout=60"
    "x-systemd.mount-timeout=5"
    #"credentials=${config.sops.secrets.samba-credentials.path}"
    "credentials=/home/vanhyr/.local/.samba/.valentin" # TODO -> change this (use sops)!
    "uid=1000"
    "gid=1000"
    #"file_mode=0660"
    #"dir_mode=0770"

    # Ajustes de rendimiento de nivel de producción
    "rsize=4194304" # Buffer optimizado de lectura secuencial (4MB)
    "wsize=4194304" # Buffer optimizado de escritura secuencial (4MB)
    "cache=strict" # Mantiene consistencia estricta en tiempo real si modificas ficheros concurrentemente
  ];
in
{
  services.gvfs = {
    enable = true;
    #package = pkgs.gnome.gvfs;
    package = pkgs.gvfs;
  };

  environment.systemPackages = [
    pkgs.cifs-utils
  ];

  #fileSystems = {
  #  "/data/samba/cipreses" = {
  #    device = "//192.168.18.51/cipreses";
  #    fsType = "cifs";
  #    options = [
  #      "_netdev"
  #      "iocharset=utf8"
  #      "cifsacl"
  #      "noauto"
  #      "x-systemd.automount"
  #      "x-systemd.idle-timeout=60"
  #      "x-systemd.mount-timeout=5"
  #      "credentials=/home/vanhyr/.local/.samba/.valentin" # TODO -> change this (use sops)!
  #      "uid=1000"
  #      "gid=1000"
  #      #"file_mode=0660"
  #      #"dir_mode=0770"
  #    ];
  #    noCheck = true;
  #  };
  #  "/data/samba/multimedia" = {
  #    device = "//192.168.18.51/multimedia";
  #    fsType = "cifs";
  #    options = [
  #      "_netdev"
  #      "iocharset=utf8"
  #      "cifsacl"
  #      "noauto"
  #      "x-systemd.automount"
  #      "x-systemd.idle-timeout=60"
  #      "x-systemd.mount-timeout=5"
  #      "credentials=/home/vanhyr/.local/.samba/.valentin" # TODO -> change this (use sops)!
  #      "uid=1000"
  #      "gid=1000"
  #      #"file_mode=0660"
  #      #"dir_mode=0770"
  #    ];
  #    noCheck = true;
  #  };
  #  "/data/samba/code" = {
  #    device = "//192.168.18.51/code";
  #    fsType = "cifs";
  #    options = [
  #      "_netdev"
  #      "iocharset=utf8"
  #      "cifsacl"
  #      "noauto"
  #      "x-systemd.automount"
  #      "x-systemd.idle-timeout=60"
  #      "x-systemd.mount-timeout=5"
  #      "credentials=/home/vanhyr/.local/.samba/.valentin" # TODO -> change this (use sops)!
  #      "uid=1000"
  #      "gid=1000"
  #      #"file_mode=0660"
  #      #"dir_mode=0770"
  #    ];
  #    noCheck = true;
  #  };
  #  "/data/samba/devices" = {
  #    device = "//192.168.18.51/devices";
  #    fsType = "cifs";
  #    options = [
  #      "_netdev"
  #      "iocharset=utf8"
  #      "cifsacl"
  #      "noauto"
  #      "x-systemd.automount"
  #      "x-systemd.idle-timeout=60"
  #      "x-systemd.mount-timeout=5"
  #      "credentials=/home/vanhyr/.local/.samba/.valentin" # TODO -> change this (use sops)!
  #      "uid=1000"
  #      "gid=1000"
  #      #"file_mode=0660"
  #      #"dir_mode=0770"
  #    ];
  #    noCheck = true;
  #  };
  #  "/data/samba/personal" = {
  #    device = "//192.168.18.51/personal";
  #    fsType = "cifs";
  #    options = [
  #      "_netdev"
  #      "iocharset=utf8"
  #      "cifsacl"
  #      "noauto"
  #      "x-systemd.automount"
  #      "x-systemd.idle-timeout=60"
  #      "x-systemd.mount-timeout=5"
  #      "credentials=/home/vanhyr/.local/.samba/.valentin" # TODO -> change this (use sops)!
  #      "uid=1000"
  #      "gid=1000"
  #      #"file_mode=0660"
  #      #"dir_mode=0770"
  #    ];
  #    noCheck = true;
  #  };
  #  "/data/samba/private" = {
  #    device = "//192.168.18.51/private";
  #    fsType = "cifs";
  #    options = [
  #      "_netdev"
  #      "iocharset=utf8"
  #      "cifsacl"
  #      "noauto"
  #      "x-systemd.automount"
  #      "x-systemd.idle-timeout=60"
  #      "x-systemd.mount-timeout=5"
  #      "credentials=/home/vanhyr/.local/.samba/.valentin" # TODO -> change this (use sops)!
  #      "uid=1000"
  #      "gid=1000"
  #      #"file_mode=0660"
  #      #"dir_mode=0770"
  #    ];
  #    noCheck = true;
  #  };
  #};

  fileSystems = lib.listToAttrs (
    map (share: {
      name = "/data/samba/${share}";
      value = {
        device = "//192.168.18.51/${share}";
        fsType = "cifs";
        options = sambaOptions;
        noCheck = true;
      };
    }) shares
  );
}
