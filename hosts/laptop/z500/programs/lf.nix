{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    lf
    pistol # previewer
  ];
}
