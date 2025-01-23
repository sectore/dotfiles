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
    };
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
