{
  ...
}:
{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/08ce1240-0369-4d5a-86fa-92b06e89cbc5"; # /dev/sda3
      fsType = "btrfs";
      options = [
        "subvol=@"
        "compress=zstd"
        "noatime"
      ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/a4b2c8a5-3e55-4558-9661-eb6a925011e5";
      fsType = "ext4";
    };
    "/boot/efi" = {
      device = "/dev/disk/by-uuid/4420-0280"; # /dev/sda2
      fsType = "vfat"; # vfat for FAT32/FAT16
      options = [
        "umask=0077" # TODO -> 0022 better?
        "dmask=0077" # TODO -> 0022 better?
        "noatime"
        #"defaults"
      ];
    };
    "/nix" = {
      device = "/dev/disk/by-uuid/08ce1240-0369-4d5a-86fa-92b06e89cbc5";
      fsType = "btrfs";
      options = [
        "subvol=@nix"
        "compress=zstd"
        "noatime"
        "space_cache=v2"
      ];
    };
    "/swap" = {
      device = "/dev/disk/by-uuid/08ce1240-0369-4d5a-86fa-92b06e89cbc5";
      fsType = "btrfs";
      options = [
        "subvol=@swap"
        "nodatacow"
        "noatime"
      ];
    };
    "/home" = {
      device = "/dev/disk/by-uuid/08ce1240-0369-4d5a-86fa-92b06e89cbc5";
      fsType = "btrfs";
      options = [
        "subvol=@home"
        "compress=zstd"
        "noatime"
      ];
    };
    "/data" = {
      device = "/dev/disk/by-uuid/09972439-4609-4e4a-8a12-ecd25b89ded2";
      fsType = "btrfs";
      options = [
        "subvol=@data"
        #"compress=zstd:3"
        "compress=zstd"
        "autodefrag"
        "noatime"
      ];
    };
    "/games" = {
      device = "/dev/disk/by-uuid/09972439-4609-4e4a-8a12-ecd25b89ded2"; # /dev/sdb1
      fsType = "btrfs";
      options = [
        "subvol=@games"
        #"compress=zstd:3"
        "compress=zstd"
        "autodefrag"
        "noatime"
      ];
    };
    #"/tmp" = {
    #  device = "tmpfs";
    #  fsType = "tmpfs";
    #  options = [ "mode=1777" "size=265M" ];
    #  noCheck = true;
    #};
  };
  # disable copy on write for the swap subvolume (for the swapfile basically)
  #systemd.tmpfiles.rules = [
  #  "d /swap 0700 root root - -"
  #  "h /swap - - - - +C"
  #];
  services = {
    fstrim.enable = true; # trim ssd
    btrfs.autoScrub = {
      enable = true;
      interval = "weekly";
    };
  };
}
