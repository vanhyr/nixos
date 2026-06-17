{
  ...
}:
{
  services.redshift = {
    enable = true;
    brightness = {
      day = "1";
      night = "1";
    };
    # Default temperature is 6500:4500, adjust to your liking
    temperature = {
      day = 6500; # 5500
      #day = 6000; # 5500
      night = 3500; # 3000
    };
    extraOptions = [
      "-m randr" # method
      "-l manual" # takes system location manually (from nix location config)
      #"-l 37.08484:-361837" # inject location explicitly
      "-g 1" # gamma
    ];
  };
}
