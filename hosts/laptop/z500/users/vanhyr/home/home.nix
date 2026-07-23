{
  ...
}:
{
  imports = [
    ./xdg/default.nix
    ./theming/default.nix
    ./thunar-daemon.nix
    ./scripts.nix
  ];

  home.stateVersion = "26.05";

  home.username = "vanhyr";
  home.uid = 1000;
  home.homeDirectory = "/home/vanhyr";
  home.preferXdgDirectories = true;
  home.enableNixpkgsReleaseCheck = false;

  programs.home-manager.enable = true;
}
