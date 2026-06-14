{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    intel-vaapi-driver
  ];
  boot = {
    blacklistedKernelModules = [
      #"nouveau"
    ];
  };
  hardware = {

    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      open = false;
      powerManagement.enable = false;
      nvidiaSettings = true;
      #branch = "legacy_470";
      #branch = "stable";

      # only works up to kernel 6.12
      # check if pkg gets patched in the mainline repo so needs no manual patching no more:
      #   https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/os-specific/linux/nvidia-x11/default.nix
      #package = config.boot.kernelPackages.nvidiaPackages.legacy_470;

      # patched the 470 driver myself so it works with the 7.0.10 kernel.
      # check these links if a new version needs revision:
      #   https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/os-specific/linux/nvidia-x11/default.nix
      #   https://github.com/joanbm/nvidia-470xx-linux-mainline/tree/master/patches
      package = (config.boot.kernelPackages.nvidiaPackages.legacy_470).overrideAttrs (oldAttrs: {
        # TODO -> for lto maybe
        #env = (oldAttrs.env or {}) // {
        #  IGNORE_CC_MISMATCH = "1";
        #};

        patches = (oldAttrs.patches or [ ]) ++ [
          (pkgs.fetchpatch {
            # ← pkgs.fetchpatch, no fetchpatch solo
            url = "https://raw.githubusercontent.com/joanbm/nvidia-470xx-linux-mainline/master/patches/nvidia-470xx-fix-linux-6.19-part1.patch";
            hash = "sha256-Swq82/0CMM8OMJz1BpgkuOngGio8cIrdXWuR05cZDa8=";
          })
          (pkgs.fetchpatch {
            url = "https://raw.githubusercontent.com/joanbm/nvidia-470xx-linux-mainline/master/patches/nvidia-470xx-fix-linux-6.19-part2.patch";
            hash = "sha256-9ykrYEl6UH3NDvfdv5sWfFUShrdRzIqf/h+OAqijRLM=";
          })
          (pkgs.fetchpatch {
            url = "https://raw.githubusercontent.com/joanbm/nvidia-470xx-linux-mainline/master/patches/nvidia-470xx-fix-linux-7.0.patch";
            hash = "sha256-mytOoDLZe8rmM/DQNMo3TxirN1RZkwjSRamg7MfsoZg=";
          })
        ];
      });

      modesetting.enable = true; # optional, only if you are experiencing problems

      # offload mode (power efficient)
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

  };

  # second boot entry for gaming (offload default, this would activate sync mode), pair this only with offload mode
  specialisation = {
    max-graphics-performance.configuration = {
      hardware.nvidia = {
        prime.sync.enable = lib.mkForce true;
        prime.offload = {
          enable = lib.mkForce false;
          enableOffloadCmd = lib.mkForce false; # probably reduntant if above is false
        };
      };
    };
  };
}
