{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    bluez
    bluez-experimental
    bluez-tools
    bluez-alsa
    blueman
    bluetuith
  ];
  hardware = {
    pulseaudio.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket"; # enable the a2dp sink
          Experimental = true; # battery charge of bt devices
        };
      };
    };
  };
  services.blueman.enable = true;
  #services.mpris-proxy.enable = true; # in home manager, for buttons control
}
