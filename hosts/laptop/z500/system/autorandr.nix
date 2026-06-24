{
  lib,
  pkgs,
  ...
}:
let
  fingerprint_lvds-1 = "00ffffffffffff004c8352450000000000160103802213780a09259257548f2922505400000001010101010101010101010101010101411c56a0500016303020250058c2100000190000000f0000000000000000001eb4027400000000fe0053414d53554e470a204c834154000000fe004c544e313536415432394c3031007f";
  fingerprint_hdmi-1 = "00ffffffffffff001c540d27010101010220010380462778ee6bf5ad5145ab260b5054ffff80714f81c08100814081809500a9c0b300565e00a0a0a029503020350055502100001e60e80078a0a067501c20980055502100001e000000fd0030901ef33c000a202020202020000000fc004d3237510a2020202020202020018802034f714f5d6102031304290e201f90403f111223091707830100006b030c00100038442000200367d85dc4017880036d1a000002013090ec0000000000e305e301e606050162622ce20f02e2006a6fc200a0a0a055503020350055502100001e967f8078703821401c20380455502100001e00000000000000000000000043";

  wallpaper = "/home/vanhyr/.local/share/wallpaper";
in
{
  environment.systemPackages = with pkgs; [
    autorandr
  ];

  services.autorandr = {
    enable = true;
    defaultTarget = "mobile";
    ignoreLid = false;
    hooks.postswitch = {
      "wallpaper" = ''
        ${pkgs.feh}/bin/feh --bg-fill ${wallpaper}
      '';
      #"update-betterlockscreen-wallpaper" = ''
      #  ${pkgs.betterlockscreen}/bin/betterlockscreen -u ${wallpaper} --blur 0.8;
      #'';
    };
    profiles = {
      "mobile" = {
        fingerprint.LVDS-1 = "${fingerprint_lvds-1}";
        config.LVDS-1 = {
          enable = true;
          primary = true;
          mode = "1366x768";
          rate = "60.00";
          position = "0x0";
        };
      };
      "docked" = {
        fingerprint = {
          #LVDS-1 = "${fingerprint_lvds-1}";
          HDMI-1 = "${fingerprint_hdmi-1}";
        };
        config = {
          #LVDS-1.enable = false;
          HDMI-1 = {
            enable = true;
            primary = true;
            mode = "1920x1080";
            rate = "60.00";
            position = "0x0";
          };
        };
      };
      "extend-left" = {
        fingerprint = {
          LVDS-1 = "${fingerprint_lvds-1}";
          HDMI-1 = "${fingerprint_hdmi-1}";
        };
        config = {
          LVDS-1 = {
            enable = true;
            primary = true;
            mode = "1366x768";
            rate = "60.00";
            position = "1920x156";
          };
          HDMI-1 = {
            enable = true;
            primary = false;
            mode = "1920x1080";
            rate = "60.00";
            position = "0x0";
          };
        };
      };
      "extend-right" = {
        fingerprint = {
          LVDS-1 = "${fingerprint_lvds-1}";
          HDMI-1 = "${fingerprint_hdmi-1}";
        };
        config = {
          LVDS-1 = {
            enable = true;
            primary = true;
            mode = "1366x768";
            rate = "60.00";
            position = "0x156";
          };
          HDMI-1 = {
            enable = true;
            primary = false;
            mode = "1920x1080";
            rate = "60.00";
            position = "1366x0";
          };
        };
      };
    };
  };

  # Wayland support
  environment.variables = {
    #WAYLAND_DISPLAY = "autorandr"; # make aurorandr use wayland
  };

  services.xserver.displayManager.sessionCommands = lib.mkBefore ''
    ${pkgs.autorandr}/bin/autorandr --change
  '';
}
