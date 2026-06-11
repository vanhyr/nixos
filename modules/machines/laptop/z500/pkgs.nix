{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    xdg-ninja

    compsize # real size for btrfs filesystems
    just

    autorandr
    fastfetch
    dysk

    intel-vaapi-driver

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

    lf
    mpv
    nsxiv

    zathura
    zathuraPkgs.zathura_pdf_poppler

    spotube
    yt-dlp

    zed-editor
    nil
    nixd

    pavucontrol
    bluetuith
    pulsemixer
    wiremix

    xclip
    xsel

    libinput

    #nix-output-monitor
  ];
}
