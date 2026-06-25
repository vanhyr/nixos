{
  pkgs,
  ...
}:
{
  programs.dconf.enable = true; # gnome apps key value store settings
  environment.systemPackages = with pkgs; [
    # fix individual
    #(hypnotix.overrideAttrs (oldAttrs: {
    #  nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.makeWrapper ];
    #  postFixup = (oldAttrs.postFixup or "") + ''
    #    wrapProgram $out/bin/hypnotix \
    #      --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.glib.bin ]}
    #  '';
    #}))
    # variante alternativa, no se cual es mejor
    #(hypnotix.overrideAttrs (oldAttrs: {
    #  nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.makeBinaryWrapper ];
    #  postFixup = (oldAttrs.postFixup or "") + ''
    #    wrapBinaryProgram $out/bin/hypnotix \
    #      --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.glib.bin ]}
    #  '';
    #}))

    hypnotix
    glib
    # no creo que sea necesario
    #gst_all_1.gstreamer
    #gst_all_1.gst-vaapi
    #gst_all_1.gst-libav
    #gst_all_1.gst-plugins-base
    #gst_all_1.gst-plugins-good
    #gst_all_1.gst-plugins-bad
    #gst_all_1.gst-plugins-ugly
    #gst_all_1.gst-plugins-rs
  ];
}
