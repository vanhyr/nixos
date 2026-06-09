{
  pkgs,
  ...
}:
{
  environment.variables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
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
}
