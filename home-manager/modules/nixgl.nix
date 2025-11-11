{nixgl, ...}: {
  # `nixGL` config
  #  https://github.com/nix-community/home-manager/blob/master/docs/manual/usage/gpu-non-nixos.md
  targets.genericLinux.nixGL = {
    packages = nixgl.packages;
    defaultWrapper = "mesa";
    offloadWrapper = "nvidia";
    installScripts = ["mesa" "nvidia"];
  };
}
