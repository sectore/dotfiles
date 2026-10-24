{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [inputs.purescript-iris-nix.packages.${pkgs.stdenv.hostPlatform.system}.iris];
}
