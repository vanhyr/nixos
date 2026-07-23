{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    android-tools
  ];
  #services.udisks2 = {
  #  enable = true;
  #};
  #users.users.vanhyr.extraGroups = [
  #  "adbusers"
  #];
}
