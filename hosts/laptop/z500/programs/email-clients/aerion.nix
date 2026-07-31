{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    #aerion
    (aerion.override {
      withOAuth = true;
    })
  ];
}
