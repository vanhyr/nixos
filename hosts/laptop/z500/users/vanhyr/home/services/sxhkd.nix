{
  pkgs,
  ...
}:
{
  services.sxhkd = {
    enable = true;
    keybindings = {
      #"super + Return" = "alacritty";
      #"super + ntilde" = "librepods";
      "super + ntilde" = "notify-send 'HOLA'";
      #"super + {x}" = "notify-send 'HOLA'";
      #"super + Escape" = "pkill -USR1 -x sxhkd";
    };
    # extraConfig = builtins.readFile ./dotfiles/sxhkdrc;
  };
  systemd.user.services.sxhkd = {
    Unit = {
      Description = "sxhkd";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.sxhkd}/bin/sxhkd";
      Restart = "always";
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };
}
