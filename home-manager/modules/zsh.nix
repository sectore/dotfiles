{ ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = false;
    initExtra = ''
      # zed
      export PATH=$HOME/.local/bin:$PATH

      # pnpm
      export PNPM_HOME="$HOME/.nix-profile/bin/pnpm"
      case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
      esac
      # pnpm end

    '';

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "npm"
        "httpie"
      ];
      theme = "jreese";
    };
  };
}
