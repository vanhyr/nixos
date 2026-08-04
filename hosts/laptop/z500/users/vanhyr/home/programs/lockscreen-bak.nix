{
  config,
  pkgs,
  ...
}:
let
  wallpaper = "${config.home.homeDirectory}/.local/share/wallpaper";

  shouldUpdateCache = pkgs.writeShellScript "check-betterlockscreen-cache" ''
      set -eu

      cache_dir="$HOME/.cache/betterlockscreen"
      wallpaper_file="$1"
      hash_file="$HOME/.cache/wallpaper_hash"

      : "''${cache_dir:?Error: cache_dir not defined}"

      if [ ! -d "$cache_dir" ]; then
        exit 0
      fi

      current_hash=$(${pkgs.coreutils}/bin/md5sum "$wallpaper_file" | ${pkgs.coreutils}/bin/cut -d' ' -f1)

      if [ ! -f "$hash_file" ] || [ "$(${pkgs.coreutils}/bin/cat "$hash_file")" != "$current_hash" ]; then
        rm -rf "$cache_dir"
        mkdir -p "$cache_dir"
        echo "$current_hash" > "$hash_file"
        exit 0
      fi

      displays=$(${pkgs.xrandr}/bin/xrandr --query | ${pkgs.gnugrep}/bin/grep " connected [^((]" | ${pkgs.gawk}/bin/awk '{print $1}')

      if [ -z "$displays" ]; then
        displays=$(${pkgs.xrandr}/bin/xrandr --query | ${pkgs.gnugrep}/bin/grep -B 1 "\*" | ${pkgs.gawk}/bin/awk '{print $1}')
      fi

      for display in $displays; do
        if ! ${pkgs.findutils}/bin/find "$cache_dir" -maxdepth 1 -type d -name "*$display*" | ${pkgs.gnugrep}/bin/grep -q .; then
          exit 0
        fi
      done

      exit 1
    '';

    updateAndCleanCache = pkgs.writeShellScript "update-betterlockscreen-cache" ''
      set -eu

      wallpaper_file="$1"

      ${pkgs.betterlockscreen}/bin/betterlockscreen -u "$wallpaper_file" --blur 0.8
      rm -rf "$HOME/.cache/betterlockscreen/"*LVDS* 2>/dev/null || true
    '';
in
{
  #home.packages = with pkgs; [
  #  betterlockscreen
  #];

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
    arguments = [
      "-l" "blur"
    ];
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
      ExecStart = "${updateAndCleanCache} \"${wallpaper}\"";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
