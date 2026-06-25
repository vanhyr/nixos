{
  ...
}:
{
  services.xserver = {
    enable = true;
    #videoDrivers = [ "nvidia" ];

    #autoRepeatDelay = 200;
    #autoRepeatInterval = 35;

    xkb = {
      model = "pc105"; # europe ISO, TODO -> or pc104 (is it trully ANSI US?)
      layout = "es";
      options = "caps:escape";
    };

    #inputClassSections = [
    #  ''
    #    Identifier "mouse"
    #    Driver "libinput"
    #    MatchIsPointer "yes"
    #    Option "AccelProfile" "flat"
    #    Option "AccelSpeed" "-1"
    #  ''
    #];

    # Disable xscreensaver
    #serverFlagsSection = ''
    #  Option "BlankTime"   "0"
    #'';
    #serverFlagsSection = ''
    #  Option "StandbyTime" "10"
    #  Option "SuspendTime" "10"
    #  Option "OffTime"     "10"
    #  Option "BlankTime"   "0"
    #'';
  };
}
