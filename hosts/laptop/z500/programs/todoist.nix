{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    todoist-electron # closed source (electron)
    planify # gnome alternative (oss)
  ];
}
