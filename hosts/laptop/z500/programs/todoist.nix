{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    todoist-electron
    planify
  ];
}
