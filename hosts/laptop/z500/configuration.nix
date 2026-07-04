{
  #config,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    #/etc/nixos/hardware-configuration.nix
  ]
  ++ (
    let
      dir = ./.;
      content = builtins.readDir dir;

      blacklist = [
        "default.nix"
        "configuration.nix"
        #"hardware-configuration.nix"
      ];

      isValidNix =
        name: type:
        (type == "regular" && lib.hasSuffix ".nix" name && !lib.elem name blacklist)
        || (
          type == "directory"
          && builtins.pathExists (dir + "/${name}/default.nix")
          && !lib.elem name blacklist
        );

      filteredContent = lib.filterAttrs isValidNix content;
    in
    lib.mapAttrsToList (name: type: dir + "/${name}") filteredContent
  );

  #imports = [
  #  ./hardware-configuration.nix
  #  #/etc/nixos/hardware-configuration.nix
  #
  #  ./storage.nix
  #  ./locale.nix
  #  ./boot.nix
  #  ./hardware.nix
  #  ./network.nix
  #  ./storage.nix
  #
  #  ./users
  #];

  console = {
    #font = "Lat2-Terminus16";
    keyMap = "es";
    #useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  environment.variables = {
    ZDOTDIR = "XDG_CONFIG_HOME/zsh";

    PAGER = "less";
    TERMINAL = "kitty";
    #EDITOR = "nvim";
    BROWSER = "helium";
    FILE_EXPLORER = "thunar";

    INTEL_AUDIO_POW_SAV = "0"; # prevents the sound card from suspending agressively

    #WAYLAND_DISPLAY = "autorandr"; # make aurorandr use wayland
  };

  programs = {
    #gnupg.agent = {
    #  enable = true;
    #  enableSSHSupport = true;
    #};

    # userspace mounting for fs
    fuse = {
      enable = true;
      userAllowOther = true;
    };
  };

  services = {
    #power-profiles-daemon.enable = false;
    tlp = {
      #enable = true;
      enable = false;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        #USB_EXCLUDE_BTUSB = 1;

        #WIFI_PWR_ON_AC = "off";
        #WIFI_PWR_ON_BAT = "off";
      };
    };
    thermald.enable = true;
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  #system.stateVersion = "25.11";

}
