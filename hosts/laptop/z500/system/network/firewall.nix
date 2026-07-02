{
  ...
}:
{
  networking = {
    nftables.enable = true; # so that the firewall uses nftables as the backend
    firewall = {
      enable = true;
      allowedTCPPorts = [
        53317 # localsend
      ];
      allowedUDPPorts = [
        53317 # localsend
      ];
    };
  };
}
