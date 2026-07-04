{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    zapzap
    #whatsie
    #karere
  ];
}
