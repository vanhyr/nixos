{
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
  };
}
