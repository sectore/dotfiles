{pkgs, ...}: {
  home.packages = with pkgs; [
    go
    gopls
    golangci-lint
    delve
    go-tools
  ];

  home.sessionPath = ["$HOME/go/bin"];

  home.sessionVariables = {
    GOPATH = "$HOME/go";
  };
}
