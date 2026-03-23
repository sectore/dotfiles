{
  config,
  pkgs,
  ...
}: {
  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.ghostty.enable
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    package = config.lib.nixGL.wrap pkgs.ghostty;
    settings = {
      font-size = 12;
      # `ghostty +list-themes` OR https://ghostty.org/docs/config/reference#theme
      theme = "One Half Light";
      # https://ghostty.org/docs/config/reference#cursor-style
      cursor-style = "block";
    };
  };

  # Override `ghostty.desktop` entry:
  # `DBusActivatable` needs to be disabled/removed to fix launcher issue I have had on my machine recently (Oct 2th 2025).
  # Background: The default Ghostty desktop file (~/.nix-profile/share/applications/com.mitchellh.ghostty.desktop)
  # has `DBusActivatable=true` defined, which points to D-Bus service file (~/.nix-profile/share/dbus-1/services/com.mitchellh.ghostty.service),
  # which tries to start `ghostty` unwraped (w/o nixGL) causing GNOME to fail launching it from Activities overview on Wayland.
  # Another solution might be to override `ghostty.service` an a similar way, but I stick with this solution for now...
  xdg.desktopEntries."com.mitchellh.ghostty" = {
    name = "Ghostty";
    comment = "A terminal emulator";
    # Make sure we still use the nixGL-wrapped Ghostty binary path we have defined in `programs.ghostty` above
    exec = "${config.programs.ghostty.package}/bin/ghostty --gtk-single-instance=true";
    icon = "com.mitchellh.ghostty";
    categories = ["System" "TerminalEmulator"];
    terminal = false;
    # Note: No DBusActivatable here
  };
}
