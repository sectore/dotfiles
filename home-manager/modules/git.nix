{ config, ... }:
{
  programs.git = {
    enable = true;
    userName = "jk";
    userEmail = "email@jkrause.io";
    extraConfig = {
      url = {
        "ssh://git@github.com/" = { 
          insteadOf = [ "https://github.com/" ]; 
        };
      };
      pull = {
        rebase = true;
      };
      push = {
        default = "simple";
      };
      core = {
        editor = "vim";
      };
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/id_ed25519.pub";
      # Conditional includes
      # https://git-scm.com/docs/git-config#_conditional_includes
      # includeIf = {
      #   "gitdir:~/xxx/yyy/" = {
      #     path = "~/xxx/yyy/.gitconfig";
      #   };
      # };
    };
  };
}
