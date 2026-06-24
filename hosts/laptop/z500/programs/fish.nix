{
  lib,
  ...
}:
{
  environment.shellAliases = lib.mkForce { }; # delete any other alias

  programs.fish = {
    enable = true;
    shellAliases = { };
    shellAbbrs = { };
    shellInit = "";
    loginShellInit = "";
    interactiveShellInit = "";
  };
}
