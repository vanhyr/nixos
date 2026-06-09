{
  #config,
  #lib,
  #pkgs,
  ...
}:
let
  files = builtins.filter (name: builtins.match ".*\\.nix" name != null && name != "default.nix") (
    builtins.attrNames (builtins.readDir ./.)
  );
in
{
  imports = map (name: ./. + "/${name}") files;

  time.timeZone = "Europe/Madrid";
  system.stateVersion = "25.11";
}
