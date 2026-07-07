{
  ...
}:
{
  programs.direnv = {
    enable = true;
    silent = false;
    nix-direnv.enable = true;
    loadInNixShell = true;
    enableFishIntegration = true;
    #enableBashIntegration = true;
    #enableZshIntegration = true;
  };
}
