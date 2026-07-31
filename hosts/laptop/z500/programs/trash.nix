{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    trash-cli
    #trashy # rust alternative
  ];
}
