{
  config,
  lib,
  pkgs,
  ... 
}:
{
  imports = [
    ./hardware-configuration.nix
    #/etc/nixos/hardware-configuration.nix
  ];

  nix = {
    settings = {
      cores = 0;
      max-jobs = "auto";
      #download-buffer-size = 4194304000; # 4GiB
      trusted-users = [ "vanhyr" ]; # root is already trusted by default, no need to add

      #substituters = [ "https://chaotic-nyx.cachix.org/" ];
      #trusted-public-keys = [ "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8=" ];

      substituters = [
        # chaotic-nyx
        #"https://chaotic-nyx.cachix.org/"

        # nyx-loner
	#"https://cache.garnix.io"

        # nix-cachyos-kernel
        #"https://attic.xuyh0120.win/lantian"
	#"https://cache.garnix.io"
      ];
      trusted-public-keys = [
        # chaotic-nyx
        #"chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="

        # nyx-loner
        #"cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        
        # nix-cachyos-kernel
	#"lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
	#"cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
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
  
  #boot.kernelPackages = pkgs.linuxPackages_latest;
 
  # chaotic-nyx
  #boot.kernelPackages = pkgs.linuxPackages_cachyos; # cachyOS kernel
  #boot.kernelPackages = pkgs.linuxPackages_cachyos-lto; # cachyOS kernel (lto)

  # nyx-loner
  #boot.kernelPackages = pkgs.linuxPackages_cachyos; # cachyOS kernel
  boot.kernelPackages = pkgs.linuxPackages_cachyos-lto; # cachyOS kernel (lto)

  # nix-cachyos-kernel
  #boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest; # cachyOS kernel
  #boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto; # cachyOS kernel (lto)

  networking = {
    hostName = "z500";
    networkmanager.enable = true;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "es_ES.UTF-8";
      LC_IDENTIFICATION = "es_ES.UTF-8";
      LC_MEASUREMENT = "es_ES.UTF-8";
      LC_MONETARY = "es_ES.UTF-8";
      LC_NAME = "es_ES.UTF-8";
      LC_NUMERIC = "es_ES.UTF-8";
      LC_PAPER = "es_ES.UTF-8";
      LC_TELEPHONE = "es_ES.UTF-8";
      LC_TIME = "es_ES.UTF-8";
    };      
  };
  
  console = {
    #font = "Lat2-Terminus16";
    keyMap = "es";
    # useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  users = {
    users = {
      vanhyr = {
        isNormalUser = true;
        uid = 1000;
        shell = pkgs.fish;
        group = "vanhyr";
        extraGroups = [ 
          "wheel"
          "users"
          "podman"
        ];
        packages = with pkgs; [
          #tree
        ];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJF6D82y0hBm0//OEhRvm1dlrkWedmCwhKSACPRxzYJ6 vanhyr@w11-redlack"
        ];
      };
    };
    groups = {
      vanhyr = {
        gid = 1000;
      };
    };
  };
  
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    xdg-ninja

    compsize # real size for btrfs filesystems
    just

    autorandr
    fastfetch

  ];

  environment.shellAliases = lib.mkForce {};

  environment.variables = {
    ZDOTDIR = "XDG_CONFIG_HOME/zsh";
    WAYLAND_DISPLAY = "autorandr"; # make aurorandr use wayland
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/08ce1240-0369-4d5a-86fa-92b06e89cbc5"; # /dev/sda3
      fsType = "btrfs";
      options = [ "subvol=@" "compress=zstd" "noatime" ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/a4b2c8a5-3e55-4558-9661-eb6a925011e5"; # /dev/sda1
      fsType = "ext4";
    };
    "/boot/efi" = {
      device = "/dev/disk/by-uuid/4420-0280"; # /dev/sda2
      fsType = "vfat"; # vfat for FAT32/FAT16
      options = [ "umask=0077" "dmask=0077" "noatime" "defaults" ];
      #neededForBoot = true; # DELETE
    };
    "/swap" = {
      device = "/dev/disk/by-uuid/08ce1240-0369-4d5a-86fa-92b06e89cbc5"; # /dev/sda3
      fsType = "btrfs";
      options = [ "subvol=@swap" "noatime" ];
    };
    "/nix" = {
      device = "/dev/disk/by-uuid/08ce1240-0369-4d5a-86fa-92b06e89cbc5"; # /dev/sda3
      fsType = "btrfs";
      options = [ "subvol=@nix" "compress=zstd" "noatime" ];
    };
    "/home" = {
      device = "/dev/disk/by-uuid/08ce1240-0369-4d5a-86fa-92b06e89cbc5"; # /dev/sda3
      fsType = "btrfs";
      options = [ "subvol=@home" "compress=zstd" "noatime" ];
    };
    "/data" = {
      device = "/dev/disk/by-uuid/09972439-4609-4e4a-8a12-ecd25b89ded2"; # /dev/sdb1
      fsType = "btrfs";
      options = [ "subvol=@data" "compress=zstd:3" "autodefrag" "noatime" ];
    };
    "/games" = {
      device = "/dev/disk/by-uuid/09972439-4609-4e4a-8a12-ecd25b89ded2"; # /dev/sdb1
      fsType = "btrfs";
      options = [ "subvol=@games" "compress=zstd:3" "autodefrag" "noatime" ];
    };
    #"/tmp" = {
    #  device = "tmpfs";
    #  fsType = "tmpfs";
    #  options = [ "mode=1777" "size=265M" ];
    #  noCheck = true;
    #};
  };

  # disable copy on write for the swap subvolume (for the swapfile basically)
  systemd.tmpfiles.rules = [
    "d /swap 0700 root root - -"
    "h /swap - - - - +C"
  ];

  programs = {
    fish = {
      enable = true;
      shellAliases = {};
      shellAbbrs = {};
      shellInit = "";
      loginShellInit = "";
      interactiveShellInit = "";
    };
    starship.enable = true;
    #gnupg.agent = {
      #enable = true;
      #enableSSHSupport = true;
    #};
  };

  zramSwap = {
    enable = true;
    priority = 100;
    memoryPercent = 50;
    algorithm = "lz4"; #or zstd - lz4 is faster and uses less cpu while compressing it less, while zstd is slower and uses more cpu while compressing it more
  };

  swapDevices = [
    {
      device = "/swap/swapfile";
      priority = 10;
      size = 8192; # MiB
    }
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services = {
    
    openssh = {
      enable = true;
      ports = [ 235 ];
      settings = {
        Banner = null;
        AllowUsers = [ "vanhyr" ];
        PasswordAuthentication = false;
        LoginGraceTime = 0; # 20?
        PermitRootLogin = "no";
        X11Forwarding = false;
        StrictModes = true;
        UsePAM = true;
        UseDns = false;
        KbdInteractiveAuthentication = false;
        PrintMotd = false;
      };
      extraConfig = "
        AddressFamily inet
        PermitEmptyPasswords no
        GSSAPIAuthentication no
        AllowAgentForwarding no
        AllowTcpForwarding no
      ";
    };

    btrfs.autoScrub = {
      enable = true;
      interval = "weekly";
    };
    
    autorandr = {
      enable = true;
      profiles = {};
    };

    ananicy = {
      enable = true;
      package = pkgs.ananicy-cpp;
      rulesProvider = pkgs.ananicy-rules-cachyos;
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;
  
  #system.stateVersion = "25.11";

}
