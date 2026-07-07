{
  ...
}:
{
  zramSwap = {
    enable = true;
    priority = 100;
    memoryPercent = 50;
    algorithm = "lz4"; # or zstd - lz4 is faster and uses less cpu while compressing it less, while zstd is slower and uses more cpu while compressing it more
  };

  swapDevices = [
    {
      device = "/swap/swapfile";
      options = [ "discard" ]; # enabling TRIM (discard) on the swap files can help avoid unnecessary copy actions on the SSD, reducing wear and potentially helping increase performance
      priority = 10;
      size = 8192; # MiB
    }
  ];
}
