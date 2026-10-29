{pkgs, ...}: let
  # `gnome-settings-daemon` provides the `org.gnome.settings-daemon.plugins.media-keys` GSettings
  # schema; without it Zoom aborts on startup (`GLib-GIO-ERROR: Settings schema ... is not installed`).
  zoom = pkgs.zoom-us.override {
    targetPkgs = p: [p.gnome-settings-daemon];
  };
  # Zoom's bundled Qt fails to init GLX in the FHS sandbox and aborts
  # (`Could not initialize GLX`, then SIGABRT in `libqxcb-glx-integration.so`).
  # Setting `QT_XCB_GL_INTEGRATION=xcb_egl` makes Qt use EGL instead of GLX, which works.
  # Wrap `zoom` / `zoom-us` and patch the .desktop entry so app-menu launches get the variable too.
  zoomEgl = pkgs.symlinkJoin {
    name = "zoom-${zoom.version}";
    paths = [zoom];
    nativeBuildInputs = [pkgs.makeWrapper];
    postBuild = ''
      for b in zoom zoom-us; do
        rm $out/bin/$b
        makeWrapper ${zoom}/bin/$b $out/bin/$b --set QT_XCB_GL_INTEGRATION xcb_egl
      done
      rm $out/share/applications/Zoom.desktop
      substitute ${zoom}/share/applications/Zoom.desktop $out/share/applications/Zoom.desktop \
        --replace-fail "Exec=zoom" "Exec=$out/bin/zoom"
    '';
    meta.mainProgram = "zoom";
  };
in {
  home.packages = [zoomEgl];
}
