{
  config,
  pkgs,
  ...
}:
let
  wallpaper = "${config.home.homeDirectory}/.local/share/wallpaper";
  stateFile = "${config.xdg.stateHome}/betterlockscreen/state";

  computeState = pkgs.writeShellScript "compute-blc-state" ''
    set -eu

    wallpaper_file="$1"
    wallpaper_hash=$(${pkgs.coreutils}/bin/md5sum "$wallpaper_file" | ${pkgs.coreutils}/bin/cut -d' ' -f1)
    screens=$(${pkgs.xorg.xrandr}/bin/xrandr --query \
      | ${pkgs.gnugrep}/bin/grep " connected" \
      | ${pkgs.gawk}/bin/awk '{print $1, $3}' \
      | ${pkgs.coreutils}/bin/sort)
    screens_hash=$(printf '%s' "$screens" | ${pkgs.coreutils}/bin/md5sum | ${pkgs.coreutils}/bin/cut -d' ' -f1)
    printf '%s-%s' "$wallpaper_hash" "$screens_hash"
  '';

  shouldUpdateCache = pkgs.writeShellScript "check-betterlockscreen-cache" ''
    set -eu
    wallpaper_file="$1"
    cache_dir="$HOME/.cache/betterlockscreen"
    state_file="${stateFile}"
    current_state=$(${computeState} "$wallpaper_file")
    if [ ! -d "$cache_dir" ] || [ ! -f "$state_file" ] \
       || [ "$(${pkgs.coreutils}/bin/cat "$state_file")" != "$current_state" ]; then
      exit 0
    fi
    exit 1
  '';

  updateCache = pkgs.writeShellScript "update-betterlockscreen-cache" ''
    set -eu
    wallpaper_file="$1"
    cache_dir="$HOME/.cache/betterlockscreen"
    state_file="${stateFile}"
    mkdir -p "$(dirname "$state_file")"
    rm -rf "$cache_dir"
    ${pkgs.betterlockscreen}/bin/betterlockscreen -u "$wallpaper_file" --blur 0.8
    ${computeState} "$wallpaper_file" > "$state_file"
  '';
in
{
  services.screen-locker = {
    xautolock = {
      enable = false; # disable auto lock
    };
    #  enable = true;
    #  lockCmd = "${pkgs.betterlockscreen}/bin/betterlockscreen -l blur";
    #
    #  xss-lock = {
    #    package = pkgs.xss-lock;
    #    # extraOptions = [ "-n" "${pkgs.dim-screen}/bin/dim-screen" ]; # (Opcional, para atenuar antes de bloquear)
    #    # screensaverCycle = 300; # (Opcional, ciclo en segundos)
    #  };
  };

  services.betterlockscreen = {
    enable = true;
    package = pkgs.betterlockscreen;
    #inactiveInterval = 10;
    inactiveInterval = 0;
    arguments = [ "-l" "blur" ];
  };

# cache wallpaper if it doesn't exist or if the wallpaper changes (also for external screens)
  systemd.user.services.betterlockscreen-update = {
    Unit = {
      Description = "Update Betterlockscreen cache";
      #After = [ "graphical-session-pre.target" ];
      After = [ "graphical-session.target" ];
      #Requisite = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecCondition = "${shouldUpdateCache} \"${wallpaper}\"";
      ExecStart = "${updateCache} \"${wallpaper}\"";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
