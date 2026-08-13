{
  pkgs,
  ...
}:
{
  services.ananicy = {
    #enable = true;
    enable = false; # broken now, doesn't build
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-rules-cachyos;
  };
}
