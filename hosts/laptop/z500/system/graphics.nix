{
  ...
}:
{
  imports = [
    ../../../../modules/nvidia/default.nix
  ];

  drivers.nvidia = {
    enable = true;
    driverVersion = "legacy-470-patched";
    #driverVersion = "legacy-470"; # recently patched up to kernel 7.1
  };
  drivers.nvidia-prime = {
    enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };
}
