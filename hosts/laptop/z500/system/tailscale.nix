{
  ...
}:
{
  services.tailscale = {
    enable = true;
    #openFirewall = true;
    useRoutingFeatures = "client";
    disableUpstreamLogging = true;
    extraDaemonFlags = [
      "--no-logs-no-support"
    ];
    #extraSetFlags = [
    #  "--accept-routes=true"
    #];
  };
  networking.firewall.checkReversePath = "loose";
}
