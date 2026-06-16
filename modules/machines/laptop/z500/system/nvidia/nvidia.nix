{
  lib,
  pkgs,
  config,
  ...
}:
#with lib; # uncomment to supress any lib. calls in the code below
let
  cfg = config.drivers.nvidia;

  patched-nvidia-470-driver = import ./patched-nvidia-470-driver.nix { inherit pkgs config; };
in
{
  options.drivers.nvidia = {
    enable = lib.mkEnableOption "Enable Nvidia drivers";
  };

  config = lib.mkIf cfg.enable {
    services.xserver.videoDrivers = [ "nvidia" ];

    boot = {
      blacklistedKernelModules = [
        #"nouveau"
      ];
    };

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          libGL
          # nvidia (vdpau)
          libvdpau
          vdpauinfo
          libva-vdpau-driver # intel to nvidia bridge
          # intel (va-api)
          intel-vaapi-driver
          libva
          libva-utils
          libvdpau-va-gl # nvidia to intel bridge
        ];
      };

      nvidia = {
        open = false;
        nvidiaSettings = true;

        modesetting.enable = true; # optional, only if you are experiencing problems
        powerManagement.enable = true; # fixes suspend bug
        powerManagement.finegrained = true;
        nvidiaPersistenced = false; # fixes suspend bug

        # only works up to kernel 6.12
        # check if pkg gets patched in the mainline repo so needs no manual patching no more:
        #   https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/os-specific/linux/nvidia-x11/default.nix
        #package = config.boot.kernelPackages.nvidiaPackages.legacy_470;

        # patched the 470 driver myself so it works with the 7.0.10 kernel.
        # check these links if a new version needs revision:
        #   https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/os-specific/linux/nvidia-x11/default.nix
        #   https://github.com/joanbm/nvidia-470xx-linux-mainline/tree/master/patches
        package = patched-nvidia-470-driver;

        #prime = {
        #  offload = {
        #    enable = true;
        #    enableOffloadCmd = true;
        #  };
        #  # integrated
        #  intelBusId = "PCI:0:2:0"; # 00:02.0
        #  # dedicated
        #  nvidiaBusId = "PCI:1:0:0"; # 01:00.0
        #};

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
    };

    # second boot entry for max performance (offload default, this would activate sync mode), pair this only with offload mode
    #specialisation = {
    #  max-graphics-performance.configuration = {
    #    system.nixos.tags = [ "max-graphics-performance" ];
    #    hardware.nvidia = {
    #      powerManagement.finegrained = lib.mkForce false;
    #
    #      prime.sync.enable = lib.mkForce true;
    #      prime.offload = {
    #        enable = lib.mkForce false;
    #        enableOffloadCmd = lib.mkForce false; # probably reduntant if above is false
    #      };
    #    };
    #  };
    #};
  };
}
