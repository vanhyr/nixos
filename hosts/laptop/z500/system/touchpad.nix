{
  #pkgs,
  ...
}:
{
  #environment.systemPackages = with pkgs; [
  #  libinput
  #];
  services.libinput = {
    enable = true;
    touchpad = {
      accelProfile = "flat";
      accelSpeed = "0.0";
      tapping = true;
      naturalScrolling = false;
      disableWhileTyping = true;
      #clickMethod = "clickfinger"; # only tap works as buttons press
      clickMethod = "buttonareas"; # tap and click works as buttons press
    };
    mouse = {
      accelProfile = "flat";
      accelSpeed = "0.0";
    };
  };
}
