{...}: {
  programs.brave = {
    enable = true;
    commandLineArgs = ["--no-default-browser-check"];
    extensions = [];
  };

  programs.google-chrome = {
    enable = true;
    commandLineArgs = ["--no-default-browser-check"];
  };

  programs.chromium = {
    enable = true;
    commandLineArgs = ["--no-default-browser-check"];
  };
}
