{
  pkgs,
  ...
}:
let
  wallpaper = "/home/vanhyr/.local/share/wallpaper";
in
{
  environment.systemPackages = with pkgs; [
    feh
  ];
  #services.xserver.displayManager.sessionCommands = ''
  #  if [ -f "${wallpaper}" ]; then
  #    ${pkgs.feh}/bin/feh --bg-fill "${wallpaper}" &
  #  else
  #    echo "⚠️ Wallpaper no encontrado: ${wallpaper}" >&2
  #  fi
  #'';
  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.feh}/bin/feh --bg-fill ${wallpaper} &
  '';
}
