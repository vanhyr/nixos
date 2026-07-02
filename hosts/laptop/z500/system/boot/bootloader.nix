{
  ...
}:
#let
#  host = "z500";
#in
{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi"; # this is if you have a separate /efi partition
      #efi.efiSysMountPoint = "/boot"; # this is if you have a separate /efi partition
      grub = {
        enable = true;
        device = "nodev"; # used for UEFI BIOS
        #device = "/dev/disk/by-uuid/4420-0280"; # used for Legacy BIOS
        efiSupport = true;
        #efiInstallAsRemovable = true; # fix if grub doesn't work
        gfxmodeBios = "auto";
        #memtest86.enable = true;
        #useOSProber = true;
        #extraGrubInstallArgs = [ "--bootloader-id=${host}" ];
        #configurationName = "${host}";
        extraConfig = ''
          insmod kbd
          set keymap=es
        '';
        extraEntries = ''
          menuentry "UEFI Firmware Settings" {
            fwsetup
          }
        '';
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
    plymouth.enable = true;
  };
}
