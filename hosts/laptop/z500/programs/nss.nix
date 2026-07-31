{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    nss
    #nssTools
  ];
}
