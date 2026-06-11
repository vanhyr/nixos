{
  pkgs,
  ...
}:
{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
      grub = {
        enable = true;
        device = "nodev"; # need to search for this
        #device = "/dev/disk/by-uuid/4420-0280"; # dunno
        efiSupport = true;
        #efiInstallAsRemovable = true; # fix if grub doesn't work
        #useOSProber = true;
      };
      limine = {
        enable = false;
        efiSupport = true;
        #efiInstallAsRemovable = true; # fix if grub doesn't work
      };
      systemd-boot = {
        enable = false;
        #xbootldrMountPoint = "/boot/efi";
      };
    };
    # default linux kernel
    #kernelPackages = pkgs.linuxPackages_latest;
    #kernelPackages = pkgs.linuxPackages_6_12; # LTS (for nvidia legacy_470 without patching)

    # chaotic-nyx and nyx-loner
    kernelPackages = pkgs.linuxPackages_cachyos; # cachyOS kernel
    #kernelPackages = pkgs.linuxPackages_cachyos-lto; # cachyOS kernel (lto) TODO -> broken cups
    #kernelPackages = pkgs.linuxPackagesFor pkgs.linuxPackages_cachyos-lto.kernel; # just the kernel TODO -> idk, better than above? maybe

    # nix-cachyos-kernel
    #kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest; # cachyOS kernel
    #kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto; # cachyOS kernel (lto)

    initrd = {
      availableKernelModules = [
        "ahci" # main SATA HDD/SSD
        "xhci_pci" # blue USB 3.0 ports
        "ehci_pci" # old USB 2.0 ports
        "usb_storage" # flash drive boot
        "sd_mod" # SCSI/SATA disks (block devices)
        "sr_mod" # CD/DVD reader
      ];
      kernelModules = [ ];
    };

    kernelModules = [
      "kvm-intel"
      "rtsx_usb" # Realtek USB bus root module
      "rtsx_usb_sdmmc" # SD/MMC Realtek memory card reader (internal USB bus)
    ];
    extraModulePackages = [ ];

    kernelParams = [
      # backlight fix
      "acpi_backlight=vendor"
      #"acpi_backlight=video"
      "ideapad_laptop.backlight=0"

      # touchpad fix
      "psmouse.synaptics_intertouch=1" # force the high precission protocol over the default bus
    ];

    blacklistedKernelModules = [
      #"nouveau"
    ];
  };
}
