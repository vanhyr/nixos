{
  pkgs,
  ...
}:
{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.symbols-only
      nerd-fonts.jetbrains-mono
      noto-fonts-color-emoji
    ];
    fontconfig = {
      enable = true;
      antialias = true;
      #subpixel = {
      #  rgba = "rgb";
      #  lcdfilter = "default";
      #};
      hinting = {
        enable = true;
        style = "slight";
        autohint = false;
      };
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
