{
  #config,
  lib,
  pkgs,
  ...
}:
let
  shares = [
    "cipreses"
    "multimedia"
    "code"
    "devices"
    "personal"
    "private"
  ];
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

    # TODO -> take a look at this
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
