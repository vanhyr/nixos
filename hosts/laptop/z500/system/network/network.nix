{
  pkgs,
  ...
}:
{
  networking = {
    hostName = "z500";
    enableIPv6 = false; # disable ipv6
    nameservers = [
      "192.168.18.50"
      "192.168.18.53"
      #"9.9.9.9"
      #"1.1.1.1"
    ];
    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openvpn
      ];
    };
  };
  services.openssh = {
    #enable = true;
    enable = false;
    ports = [ 235 ];
    settings = {
      Banner = null;
      AllowUsers = [ "vanhyr" ];
      PasswordAuthentication = false;
      LoginGraceTime = 0; # 20?
      PermitRootLogin = "no";
      X11Forwarding = false;
      StrictModes = true;
      UsePAM = true;
      UseDns = false;
      KbdInteractiveAuthentication = false;
      PrintMotd = false;
    };
    extraConfig = "
      AddressFamily inet
      PermitEmptyPasswords no
      GSSAPIAuthentication no
      AllowAgentForwarding no
      AllowTcpForwarding no
    ";
  };
}
