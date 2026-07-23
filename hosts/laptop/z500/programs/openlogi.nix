{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    openlogi # only aarch64 for now
  ];
}
