{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    xkill
  ];
}
