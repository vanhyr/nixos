{
  pkgs,
  ...
}:
{
  programs.ente-auth = {
    enable = true;
    package = pkgs.ente-auth;
  };
}
