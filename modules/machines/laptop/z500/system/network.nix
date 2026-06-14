{
  ...
}:
{
  networking = {
    hostName = "z500";
    networkmanager.enable = true;
  };
  services.openssh = {
    enable = true;
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
  location = {
    latitude = 37.08484;
    longitude = -3.61837;
  };
}
