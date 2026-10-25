{
  inputs,
  pkgs,
  ...
}: let
  psPkgs = import pkgs.path {
    inherit (pkgs.stdenv.hostPlatform) system;
    overlays = [inputs.purescript-overlay.overlays.default];
  };
in {
  home.packages = with psPkgs; [
    purs
    spago
    purs-tidy
    purs-backend-es
    purescript-language-server
  ];
}
