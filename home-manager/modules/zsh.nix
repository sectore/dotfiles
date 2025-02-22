{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = false;
    shellAliases = {
      # `nixGLNvidia-550.120` needs to be installed via `nix-channel` before
      #  see https://github.com/sectore/dotfiles?tab=readme-ov-file#nixgl
      nixGLNvidia = "nixGLNvidia-550.120";
      # Discord's sandbox requires specific permissions
      discord = "discord --no-sandbox";
    };
    initExtra = ''
      # pnpm https://pnpm.io/
      export PNPM_HOME="$HOME/.nix-profile/bin/pnpm"
      case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
      esac
      # pnpm end

      # https://mise.jdx.dev/installing-mise.html#zsh
      eval "$(mise activate zsh)"
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "httpie"
        # https://mise.jdx.dev/installing-mise.html#autocompletion
        "mise"
        "npm"
      ];
      theme = "jreese";
    };
  };
}
