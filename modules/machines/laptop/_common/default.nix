{
  config,
  lib,
  pkgs,
  ...
}:
{

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    optimise = {
      automatic = true;
      dates = [ "daily" ];
    };
    settings = {
      use-xdg-base-directories = true;
      experimental-features = [ "nix-command" "flakes" ];
      #auto-optimise-store = true;
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      #allowUnfreePredicate = (_:true); # TODO -> see how to integrate this
    };
  };

  time.timeZone = "Europe/Madrid";

  security = {
    doas = {
      enable = lib.mkDefault true;
      wheelNeedsPassword = lib.mkDefault true;
      extraRules = [
        {
          groups = [ "wheel" ];
	  persist = true;
	  #keepEnv = true;
        }
      ];
    };
    sudo = {
      enable = lib.mkDefault true;
      #wheelNeedsPassword = lib.mkDefault false;
    };
  };

  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    eza
    bat
    btop
    zoxide
    delta

    zsh
    #fish

    #doas

    rsync
    ncdu
    speedtest-cli
    net-tools
    iperf3
    #starship
  ];

  environment.variables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
  };

  system.stateVersion = "25.11";

}
