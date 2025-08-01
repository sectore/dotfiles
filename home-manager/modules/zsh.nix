{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = false;
    shellAliases = {
      # `nixGLNvidia-550.163.01` needs to be installed via `nix-channel` before
      #  see https://github.com/sectore/dotfiles?tab=readme-ov-file#nixgl
      nixGLNvidia = "nixGLNvidia-575.64.03";
      # Discord's sandbox requires specific permissions
      discord = "discord --no-sandbox";
      # extra git aliases (using `git` plugin of `oh-my-zsh`)
      # gbde (git-branch-delete-extra)
      gbde = "gb | grep -Ev 'main|master' | xargs git branch -D";
    };
    initContent = ''
      # pnpm https://pnpm.io/
      export PNPM_HOME="$HOME/.nix-profile/bin/pnpm"
      case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
      esac
      # pnpm end

      # https://mise.jdx.dev/installing-mise.html#zsh
      # eval "$(mise activate zsh)"
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "httpie"
        # https://mise.jdx.dev/installing-mise.html#autocompletion
        # "mise"
        "npm"
      ];
      theme = "jreese";
    };
  };
}
