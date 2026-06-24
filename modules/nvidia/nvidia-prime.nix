{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.drivers.nvidia-prime;
in
{
  options.drivers.nvidia-prime = {
    enable = lib.mkEnableOption "Enable Nvidia Prime hybrid";
    # integrated
    intelBusId = lib.mkOption {
      type = lib.types.str;
      default = "PCI:0:2:0"; # 00:02.0
    };
    # dedicated
    nvidiaBusId = lib.mkOption {
      type = lib.types.str;
      default = "PCI:1:0:0"; # 01:00.0
    };
  };

  # only works if nvidia driver is enabled and this config is enabled
  # offload mode (power efficient)
  config = lib.mkIf (config.drivers.nvidia.enable && cfg.enable) {
    hardware.nvidia = {
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "${cfg.intelBusId}";
        nvidiaBusId = "${cfg.nvidiaBusId}";
      };

      # sync mode (max performance)
      #prime = {
      #  sync.enable = true;
      #
      #  intelBusId = "${cfg.intelBusId}";
      #  nvidiaBusId = "${cfg.nvidiaBusId}";
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

        services.xserver.displayManager.sessionCommands = lib.mkBefore ''
          ${pkgs.xrandr}/bin/xrandr --setprovideroutputsource modesetting NVIDIA-0
          ${pkgs.xrandr}/bin/xrandr --auto
        '';
      };
    };
  };
}
