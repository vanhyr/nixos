{
  ...
}:
{
  imports = [
    ../../../../modules/nvidia/default.nix
  ];

  drivers.nvidia = {
    enable = true;
    #driverVersion = "legacy-470-patched"; # patched up to kernel 7.2 manually
    driverVersion = "legacy-470"; # recently patched up to kernel 7.1 upstream
  };
  drivers.nvidia-prime = {
    enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };
}
