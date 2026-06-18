{
  config,
  lib,
  ...
}:
{
  # only works if nvidia driver is enabled
  # offload mode (power efficient)
  config = lib.mkIf config.drivers.nvidia.enable {
    hardware.nvidia = {
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        # integrated
        intelBusId = "PCI:0:2:0"; # 00:02.0
        # dedicated
        nvidiaBusId = "PCI:1:0:0"; # 01:00.0
      };

      # sync mode (max performance)
      #prime = {
      #  sync.enable = true;
      #
      #  # integrated
      #  intelBusId = "PCI:0:2:0"; # 00:02.0
      #  # dedicated
      #  nvidiaBusId = "PCI:1:0:0"; # 01:00.0
      #};
    };

    # second boot entry for max graphical performance (offload default, this would activate sync mode), pair this only with offload mode
    specialisation = {
      max-graphics-performance.configuration = {
        system.nixos.tags = [ "max-graphics-performance" ];
        hardware.nvidia = {
          powerManagement = {
            enable = lib.mkForce false;
            finegrained = lib.mkForce false;
          };

          prime.sync.enable = lib.mkForce true;
          prime.offload = {
            enable = lib.mkForce false;
            enableOffloadCmd = lib.mkForce false; # probably reduntant if above is false
          };
        };
      };
    };
  };
}
