{...}: {
  programs.keychain = {
    enable = true;
    keys = ["~/.ssh/id_ed25519"];
    agents = ["ssh"];
    enableZshIntegration = true;
  };
}
