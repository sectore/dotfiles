{ pkgs, lib, ... }:

{ nixpkgs.config.allowUnfreePredicate = pkg: 
    builtins.elem (lib.getName pkg) [
      "discord"
    ];

  home.packages = with pkgs; [
    discord
  ];
}
