{...}: {
  programs.keychain = {
    enable = true;
    keys = ["~/.ssh/id_ed25519"];
    enableZshIntegration = true;
  };
}
