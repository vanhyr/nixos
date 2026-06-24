{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    android-tools
    jmtpfs # fuse fs for mtp devices
  ];
  #services.udisks2 = {
  #  enable = true;
  #};
  #users.users.vanhyr.extraGroups = [
  #  "adbusers"
  #];
}
