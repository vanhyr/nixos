{
  pkgs,
  ...
}:
{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      #jetbrains-mono
      nerd-fonts.symbols-only
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
