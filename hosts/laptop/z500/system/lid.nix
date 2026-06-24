{
  ...
}:
{
  # available options at https://www.freedesktop.org/software/systemd/man/logind.conf.html
  services.logind = {
    enable = true;
    settings.Login = {
      #HoldoffTimeoutSec = 0;
      HandleLidSwitch = "suspend";
      #HandleLidSwitch = "sleep";
      HandleLidSwitchExternalPower = "ignore";
      HandleLidSwitchDocked = "ignore";
      LidSwitchIgnoreInhibited = "no"; # permit inhibitors (like music players) to prevent suspend
      IdleAction = "suspend";
      #IdleAction = "sleep";
      IdleActionSec = "30min";
    };
  };
}
