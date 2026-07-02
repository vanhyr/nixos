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

    rofi
    kitty

    libnotify

    # for thunar
    file-roller

    # for the rofi-power script
    procps
    psmisc

    brave

    scrot

    mpv
    #ffmpeg
    ffmpeg-full

    nsxiv

    zathura
    zathuraPkgs.zathura_pdf_poppler

    spotify

    spotube
    yt-dlp

    zed-editor
    nil
    nixd

    xclip
    xsel

    karere
    whatsie
    zapzap

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

    tuliprox

    librepods

    python3
    #pipx

    stremio-linux-shell

    openvpn

    # apk inspection
    binutils
    apktool
    #findutils

    localsend

    #nix-output-monitor
  ];
}
