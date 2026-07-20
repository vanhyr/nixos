{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    wiremix
    pamixer
    pavucontrol
    pulsemixer
    playerctl # mpris
    #alsa-utils # amixer
  ];

  services = {
    pulseaudio = {
      enable = false;
      package = pkgs.pulseaudioFull;
      #extraConfig = "
      #  load-module module-switch-on-connect
      #";
    };
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
      audio.enable = true;
      wireplumber = {
        enable = true;
        #extraConfig = {
        #  "11-bluetooth-policy" = {
        #    "wireplumber.settings" = {
        #      "bluetooth.autoswitch-to-headset-profile" = false;
        #    };
        #  };
        #};
      };
    };
  };

  security.rtkit.enable = true; # not sure
}
