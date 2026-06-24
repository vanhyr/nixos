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
  };
  drivers.nvidia-prime = {
    enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };
}
