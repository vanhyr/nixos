{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    xdg-ninja

    compsize # real size for btrfs filesystems

    just

    fastfetch
    maxfetch
    dysk

    kitty

    libnotify

    # for thunar
    file-roller

    # for the rofi-power script
    procps
    psmisc

    scrot

    mpv
    #ffmpeg
    ffmpeg-full

    nsxiv

    zed-editor
    nil
    nixd

    xclip
    xsel

    duf
    nitrogen

    lxappearance
    lxappearance-gtk2
    nwg-look

    arandr

    # for btop?
    pciutils
    intel-gpu-tools
    nvtopPackages.nvidia # not sure

    #libsForQt5.qt5ct
    #libsForQt5.qtstyleplugin-kvantum # activate it with qt.style = kvantum

    #qt6Packages.qt6ct
    #qt6Packages.qtstyleplugin-kvantum # activate it with qt.style = kvantum

    #catppuccin-cursors
    #catppuccin-gtk
    #catppuccin-qt5ct
    #catppuccin-kvantum

    librepods

    openvpn

    # apk inspection
    binutils
    apktool
    #findutils

    brightnessctl
  ];
}
