{
  pkgs,
  ...
}:
{
  services.gvfs.enable = true;

  environment.systemPackages = [
    pkgs.cifs-utils
  ];

  fileSystems."/mnt/red_privada" = {
    device = "//192.168.18.51/private";
    fsType = "cifs";
    options = [
      # Systemd levanta el montaje instantáneamente solo cuando accedes a la ruta física
      "x-systemd.automount"
      "noauto"
      # Desmonta automáticamente tras 5 minutos de inactividad para liberar recursos
      "x-systemd.idle-timeout=300"
      # Ruta local segura hacia las credenciales de autenticación (evita exponer texto plano en el Nix Store)
      "credentials=/home/vanhyr/.local/.smb/valentin" # TODO -> change this!
      # Mapeo de permisos UNIX locales (Ajusta uid=1000 al ID de tu usuario local principal)
      "uid=1000"
      "gid=1000"
      #"file_mode=0660"
      #"dir_mode=0770"
    ];
  };
}
