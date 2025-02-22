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
      # https://ghostty.org/docs/config/reference#theme
      theme = "OneHalfLight";
      # https://ghostty.org/docs/config/reference#cursor-style
      cursor-style = "block";
    };
  };
}
