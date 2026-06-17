{
  pkgs,
  ...
}:
#let
#  wallpaper = "/home/vanhyr/.local/share/wallpaper";
#  cache_dir = "/home/vanhyr/.cache/betterlockscreen";
#  cache_mark = "${cache_dir}/last-update";
#in
{
  environment.systemPackages = with pkgs; [
    betterlockscreen
  ];

  programs = {
    # enable lockscreen when suspending
    xss-lock = {
      enable = true;
      lockerCommand = "${pkgs.betterlockscreen}/bin/betterlockscreen -l blur";
    };
    # for betterlockscreen
    i3lock.enable = true;
  };

  #system.activationScripts.betterlockscreen = {
  #  text = ''
  #    if [ ! -f "${wallpaper}" ]; then
  #      echo "WARNING: Wallpaper not found at ${wallpaper}"
  #      exit 0
  #    fi
  #    mkdir -p "${cache_dir}"
  #    if [ ! -f "${cache_mark}" ] || [ "${wallpaper}" -nt "${cache_mark}" ]; then
  #      echo "Updating betterlockscreen cache with: ${wallpaper}"
  #      ${pkgs.betterlockscreen}/bin/betterlockscreen -u "${wallpaper}" --blur 0.8
  #      touch "${cache_mark}"
  #      echo "Betterlockscreen cache updated"
  #    else
  #      echo "Cache is already updated (it didn't regenerate)"
  #    fi
  #  '';
  #  deps = [ "users" ];
  #};
}
