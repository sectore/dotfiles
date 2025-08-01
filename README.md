# dotfiles

## `Nix` + `Home Manager` on `Ubuntu`

### Install Nix

:eyes: Multi-user installation (recommended) https://nixos.org/download.html#nix-quick-install


### Enable `Flakes`

:eyes: https://nixos.wiki/wiki/Flakes#Permanent

:eyes: [nix/README](./nix/README)


### Install standalone `Home Manager`

:eyes: https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone

```sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

nix-shell '<home-manager>' -A install
```

Check installation

```sh
nix-env --query --installed
home-manager-path

# or

home-manager --version
25.05-pre
```

### Checkout and symlink dotfiles

```sh
git pull git@github.com:sectore/dotfiles.git
cd dotfiles
```

Symlink `home-manager`, `nix` and `zed` folder to `~/.config` using [stow](https://www.gnu.org/software/stow/manual/stow.html#Introduction) based on YT vid [Stow has forever changed the way I manage my dotfiles](https://www.youtube.com/watch?v=y6XCebnB9gs)

```sh
stow . -t ~/.config
```

Side note: `home-manager` provides [`programs.zed-editor`](https://nix-community.github.io/home-manager/options.xhtml#opt-programs.zed-editor.enable),
but it errors while creating symlinks to `settings.json` etc., which Zed tries to override. That ends in errors such as
```sh
Permission denied (os error 13) at path "/nix/store/..."
# or
Failed to write settings to file "/nix/store/xxr...-zed-user-settings"
```
Very similar to https://github.com/zed-industries/zed/issues/16618

Solution is just to add `pkgs.zed-editor` to `home.packages` and symlink Zed's settings files etc. located in `~/dotfiles/zed/` by using `stow`.

Activate configuration of `home-manager` after setup or any future changes:

```sh
home-manager switch
```

### Configuration of Home Manager and programs

- Packages https://search.nixos.org/packages?channel=unstable
- Configuration Options
   - https://nix-community.github.io/home-manager/options.html
   - https://mipmip.github.io/home-manager-option-search/

### Change default shell to `zsh`

Home Manager can't change the default shell, so we need to do it manually:

```sh
# `which zsh`
which zsh
~/.nix-profile/bin/zsh

# add it to `/etc/shells`
sudo vi /etc/shells

# change shell to `zsh`
chsh -s ~/.nix-profile/bin/zsh
```
Reference:
   - How to make ZSH the default shell? https://askubuntu.com/a/1054798
   - Change my default shell in Linux using chsh https://www.cyberciti.biz/faq/change-my-default-shell-in-linux-using-chsh/

### `NixGL`

> To access the GPU, programs need access to OpenGL and Vulkan libraries. While this works transparently on NixOS, it does not on other Linux systems. A solution is provided by NixGL, which can be integrated into Home Manager.

^ https://nix-community.github.io/home-manager/index.xhtml#sec-usage-gpu-non-nixos

Needed to run [`Zed`](https://zed.dev), [`Ghostty`](https://ghostty.org), [`Bevy`](https://bevyengine.org) etc.

From [Bevy's docs](https://github.com/bevyengine/bevy/blob/main/docs/linux_dependencies.md#nix):

> If running nix on a non NixOS system (such as ubuntu, arch etc.), NixGL is additionally required, to link graphics drivers into the context of software installed by nix:

#### Installation

[nixGL docs](https://github.com/nix-community/nixGL?tab=readme-ov-file#nix-channel-recommended) recommends to install `nixGL` via `nix-channel`

```sh
# add channel
nix-channel --add https://github.com/nix-community/nixGL/archive/main.tar.gz nixgl
nix-channel --update
# install nixGL
nix-env -iA nixgl.auto.nixGLDefault
# double check
which nixGL
# install nixGLNvidia
nix-env -if https://github.com/guibou/nixGL/archive/main.tar.gz -A auto.nixGLNvidia
# double check
which nixGLNvidia-575.64.03
# (after setting a symlink in `zsh.nix` and running `home-manager switch`)
which nixGLNvidia
```

#### Uninstall

```sh
nix-env -e nixGL
nix-channel --remove nixgl
nix-channel --update
```

### Acknowledge

- NixOS Wiki: [Flakes](https://nixos.wiki/wiki/Flakes)
- Home Manager: [Documentation](https://nix-community.github.io/home-manager/)
- Zero to Flakes: [Using direnv to manage dev environments](https://zero-to-flakes.com/direnv)
- Johannes Schickling: [Setting up Nix on macOS from scratch (incl. dotfiles via home-manager and Nix flakes)](https://www.youtube.com/watch?v=1dzgVkgQ5mE)
- Vimjoyer: [Nix home-manager tutorial: Declare your entire home directory](https://www.youtube.com/watch?v=FcC2dzecovw&list=PLko9chwSoP-15ZtZxu64k_CuTzXrFpxPE&index=4)
- Alex Pearce: [Managing dotfiles with Nix](https://alexpearce.me/2021/07/managing-dotfiles-with-nix/)
- Red Tomato: [My Nix Journey - Use Nix on Ubuntu](https://tech.aufomm.com/my-nix-journey-use-nix-with-ubuntu/)
