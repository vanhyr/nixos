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
  hardware.printers = {
    ensureDefaultPrinter = "Epson_ET-3850";
    #ensureDefaultPrinter = "Epson_ET-3850_IPP";
    ensurePrinters = [
      {
        # Epson ET-3850 (escpr2 drivers)
        name = "Epson_ET-3850";
        #location = "home";
        deviceUri = "ipps://192.168.18.150:631/ipp/print";
        #deviceUri = "ipps://192.168.18.150/ipp/print";
        model = "epson-inkjet-printer-escpr2/Epson-ET-3850_Series-epson-escpr2-en.ppd";
        # check options with: lpoptions -p Epson_ET-3850 -l
        ppdOptions = {
          MediaType = "PLAIN_NORMAL"; # or PLAIN_HIGH
          Ink = "COLOR"; # or MONO
          Duplex = "DuplexNoTumble"; # or None or DuplexTumble (horizontal)
          PageSize = "A4";
        };
      }
      {
        # Epson ET-3850 (ipp, driverless)
        name = "Epson_ET-3850_IPP";
        #location = "home";
        deviceUri = "ipps://192.168.18.150:631/ipp/print";
        #deviceUri = "ipps://192.168.18.150/ipp/print";
        model = "everywhere";
        # (doesn't seems to work when using driverless) check options with: lpoptions -p Epson_ET-3850_IPP -l
        #ppdOptions = {
        #  PageSize = "A4"; # or A4.Borderless
        #  MediaType = "Stationery";
        #  cupsPrintQuality = "Normal"; # or Draft or High
        #  ColorModel = "Gray"; # or RGB (color)
        #  Duplex = "DuplexNoTumble"; # or None or DuplexTumble (horizontal)
        #};
      }
    ];
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
        #gutenprint # general printer drivers
        epson-escpr2 # epson new drivers
      ];
      cups-pdf = {
        enable = true;
      };
      browsed.enable = true; # remote printer discovery
    };
  };
}
