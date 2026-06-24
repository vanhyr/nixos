{
  pkgs,
  ...
}:
{
  boot = {
    # default linux kernel
    #kernelPackages = pkgs.linuxPackages_latest;
    #kernelPackages = pkgs.linuxPackages_6_12; # LTS (for nvidia legacy_470 without patching)

    # chaotic-nyx and nyx-loner
    kernelPackages = pkgs.linuxPackages_cachyos-gcc; # cachyOS kernel
    # lto breaks! marks nvidia and cups as broken
    #kernelPackages = pkgs.linuxPackages_cachyos; # cachyOS kernel (now it applies lto)
    #kernelPackages = pkgs.linuxPackages_cachyos-lto; # cachyOS lto kernel
    #kernelPackages = pkgs.linuxPackages_cachyos-rc; # cachyOS RC kernel, is not cached! (applies lto)
    # idk
    #kernelPackages = pkgs.linuxPackages_cachyos-lto.kernel; # just the kernel TODO -> idk, better than above? maybe
    #kernelPackages = pkgs.legacyPackages.x86_64-linux.linuxPackages_cachyos-lto; # try this maybe, just kernel, no overlay or modules

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

      # fix nvidia suspend bug
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"

      # touchpad fix
      #"psmouse.synaptics_intertouch=1" # force the high precission protocol over the default bus
    ];

    blacklistedKernelModules = [
      #
    ];
  };
}
