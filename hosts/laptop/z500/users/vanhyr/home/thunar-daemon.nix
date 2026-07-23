{
  pkgs,
  ...
}:
{
  systemd.user.services.thunar-daemon = {
    Unit = {
      Description = "Thunar File Manager Daemon";
      Documentation = "man:thunar(1)";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Type = "dbus";
      BusName = "org.xfce.FileManager";
      ExecStart = "${pkgs.thunar}/bin/thunar --daemon";
      ExecStop = "${pkgs.thunar}/bin/thunar --quit";
      Restart = "on-failure";
      RestartSec = "3s";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
