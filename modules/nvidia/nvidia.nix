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
    driverVersion = lib.mkOption {
      type = lib.types.enum [
        "production"
        "legacy-470"
        "legacy-470-patched"
      ];
      default = "production";
      description = "Driver version to use";
    };
  };

  config = lib.mkIf cfg.enable {
    services.xserver.videoDrivers = [ "nvidia" ];

    # lto kernels fix
    #nixpkgs.overlays = [
    #  (final: prev: {
    #    cups = prev.cups.overrideAttrs (oldAttrs: {
    #      meta = (oldAttrs.meta or { }) // {
    #        broken = false;
    #      };
    #    });
    #  })
    #];

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

        modesetting.enable = true;

        powerManagement = {
          enable = true; # fixes suspend bug
          finegrained = false; # turns off gpu when not in use, experimental (turing or newer)
        };
        nvidiaPersistenced = false; # fixes suspend bug

        # patched the 470 driver myself so it works with the 7.2 kernel.
        # check these links if a new version needs revision:
        #   https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/os-specific/linux/nvidia-x11/default.nix
        #   https://github.com/joanbm/nvidia-470xx-linux-mainline/tree/master/patches
        package =
          if cfg.driverVersion == "legacy-470-patched" then
            patched-nvidia-470-driver # works up to kernel 7.2
          else if cfg.driverVersion == "legacy-470" then
            config.boot.kernelPackages.nvidiaPackages.legacy_470 # works up to kernel 7.1
          else
            config.boot.kernelPackages.nvidiaPackages.production;
      };
    };
  };
}
