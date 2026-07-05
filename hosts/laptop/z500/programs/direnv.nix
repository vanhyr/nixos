{
  ...
}:
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    silent = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
