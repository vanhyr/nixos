{
  pkgs,
  ...
}:
{
  users.users.vanhyr = {
    extraGroups = [
      "lpadmin"
      "lp"
      "scanner"
    ];
  };
  environment.systemPackages = with pkgs; [
    system-config-printer # gtk frontend to cups
    naps2 # scan program
  ];
  hardware.sane = {
    enable = true; # support for sane scanners
    extraBackends = with pkgs; [
      sane-airscan
    ];
    #openFirewall = true; # just for cannon scanners
  };
  services = {
    #ipp-usb.enable = true; # auto discover usb printers
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true; # open firewall rule for avahi (5353/UDP)
    };
    printing = {
      enable = true;
      #startWhenNeeded = true; # socket activated when needed instead of a permanently running daemon
      drivers = with pkgs; [
        cups-filters
        cups-browsed
      ];
      cups-pdf = {
        enable = true;
      };
      browsed.enable = true; # remote printer discovery
    };
  };
}
