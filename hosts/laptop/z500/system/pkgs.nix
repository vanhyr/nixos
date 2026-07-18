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

    arandr # enable once it's fixed (https://github.com/NixOS/nixpkgs/commit/e7a3ca8092b61ff85b6a45bf863ea2b2d6a661b3)

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

    bc
  ];
}
