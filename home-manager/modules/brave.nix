{...}: {
  programs.brave = {
    enable = true;

    commandLineArgs = ["--no-default-browser-check"];
    extensions = [];
  };
}
