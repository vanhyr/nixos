{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    rofi
    rofi-emoji
    rofi-calc
    #rofi-nerdy # nerd icons
    #rofi-network-manager
    #rofi-screenshot
  ];
}
