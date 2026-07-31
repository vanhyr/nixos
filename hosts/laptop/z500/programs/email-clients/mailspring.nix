{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    #mailspring
    (mailspring.override {
      commandLineArgs = "--password-store=gnome-libsecret";
    })
  ];
}
