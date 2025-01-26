{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./modules/direnv.nix
    ./modules/git.nix
    ./modules/rust.nix
    ./modules/starship.nix
    ./modules/terminal.nix
    ./modules/unfree.nix
    ./modules/zsh.nix
  ];

  # Notes about `NixGL`:
  # (1) To import `nixgl`, it needs to be installed via `nix-channels` before.
  # Check https://github.com/sectore/dotfiles?tab=readme-ov-file#nixgl
  # (2) Configuration, see https://github.com/nix-community/home-manager/blob/master/docs/manual/usage/gpu-non-nixos.md
  nixGL.packages = import <nixgl> {inherit pkgs;};
  nixGL.defaultWrapper = "mesa";
  nixGL.offloadWrapper = "nvidia";
  nixGL.installScripts = ["mesa" "nvidia"];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jk";
  home.homeDirectory = "/home/jk";

  targets.genericLinux.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.
  home.enableNixpkgsReleaseCheck = false;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    du-dust
    glibc
    httpie
    htop
    jq
    neofetch
    onefetch
    openssh
    pdftk
    stow # symlink farm manager - https://www.gnu.org/software/stow/
    ffmpeg_7-full
    vlc
    # telegram-desktop
    discord

    # nix
    nil
    nixd
    nix-info
    alejandra
    cachix

    # node and stuff
    fnm # Fast Node Manager https://github.com/Schniz/fnm
    bun
    nodejs_20
    nodejs_20.pkgs.pnpm
    yarn
    deno

    # elm
    elmPackages.elm
    elmPackages.elm-format
    elmPackages.elm-test
    elmPackages.elm-review
    elmPackages.elm-live
    elmPackages.elm-land

    # misc
    taplo # TOML tooklit https://taplo.tamasfe.dev/
    simple-http-server
    vhs

    # Note: To avoid symlink related issues use `pkgs.zed-editor` instead of `programs.zed-editor`
    # see https://github.com/sectore/dotfiles?tab=readme-ov-file#checkout-and-symlink-dotfiles for more details.
    (config.lib.nixGL.wrappers.nvidia zed-editor)

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jk/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zoxide.enable = true;
}
