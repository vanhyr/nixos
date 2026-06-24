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
      priority = 10;
      size = 8192; # MiB
    }
  ];
}
