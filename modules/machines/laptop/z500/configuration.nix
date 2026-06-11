{
  #config,
  lib,
  pkgs,
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
        || (type == "directory" && builtins.pathExists (dir + "/${name}/default.nix"));

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

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  fonts.packages = [
    #fonts.packages = with pkgs; [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  environment.shellAliases = lib.mkForce { };

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
    fish = {
      enable = true;
      shellAliases = { };
      shellAbbrs = { };
      shellInit = "";
      loginShellInit = "";
      interactiveShellInit = "";
    };
    starship.enable = true;
    #gnupg.agent = {
    #enable = true;
    #enableSSHSupport = true;
    #};
    nh = {
      enable = true;
    };
    firefox = {
      enable = true;
    };
    thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
    xfconf.enable = true; # for saving thunar options
    helium = {
      enable = true;
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services = {

    autorandr = {
      enable = true;
      profiles = { };
    };

    ananicy = {
      enable = true;
      package = pkgs.ananicy-cpp;
      rulesProvider = pkgs.ananicy-rules-cachyos;
    };

    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];

      #autoRepeatDelay = 200;
      #autoRepeatInterval = 35;

      xkb = {
        model = "pc105"; # europe ISO, TODO -> or pc104 (is it trully ANSI US?)
        layout = "es";
        options = "caps:escape";
      };

      windowManager = {
        dwm = {
          enable = true;
          package = pkgs.dwm.overrideAttrs (oldAttrs: {
            src = pkgs.lib.cleanSource ../../../../config/dwm;
            buildInputs = (oldAttrs.buildInputs or [ ]) ++ [
              pkgs.libxcb
              #pkgs.libx11
            ];
          });
        };
      };
    };

    displayManager = {
      ly = {
        enable = true;
        #settings = {
        #
        #};
      };
    };

    dunst = {
      enable = true;
      #settings = {
      #
      #};
    };

    # for thunar
    gvfs.enable = true;
    tumbler.enable = true;

    picom = {
      enable = true;
    };

    redshift = {
      enable = true;
      brightness = {
        day = "1";
        night = "1";
      };
      temperature = {
        day = 5500; # 6000
        night = 3700; # 3500
      };
    };

    fstrim.enable = true;

    power-profiles-daemon.enable = false;
    tlp = {
      enable = true;
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
