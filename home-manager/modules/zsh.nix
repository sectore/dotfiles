{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = false;
    shellAliases = {
      # git aliases (using `git` plugin of `oh-my-zsh`)
      # gbde == git-branch-delete-extra
      gbde = "gb | grep -Ev 'main|master' | xargs git branch -D";
      # nix aliases
      # Garbage Collection
      # https://nix.dev/manual/nix/2.34/package-management/garbage-collection.html
      ncg = "nix-collect-garbage -d";
      # `nix develop` + zsh
      # https://nix.dev/manual/nix/2.34/command-ref/new-cli/nix3-develop.html#opt-command
      nd = "nix develop --command zsh";
      nfu = "nix flake update";
      hms = "home-manager switch";
      hmsi = "home-manager switch --impure";
      # reload
      r = "exec zsh";
    };
    initContent = ''
      # show aliases by given arg
      # example: `$ a git`
      a() { alias | grep "$1"; }

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
