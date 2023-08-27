# dotfiles

Few notes (personal reminder only):

### `Nix` + `Home Manager`

#### Install Nix

:eyes: Multi-user installation (recommended) https://nixos.org/download.html#nix-quick-install


#### Enable `Flakes` 

:eyes: https://nixos.wiki/wiki/Flakes#Permanent

:eyes: [nix/README](./nix/README)


#### Install standalone `Home Manager`

:eyes: https://nix-community.github.io/home-manager/index.html#sec-install-standalone

``` shell
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

nix-shell '<home-manager>' -A install
```

Check installation

``` shell
nix-env --query --installed
home-manager-path

# or 

home-manager --version
23.11-pre
```

#### Configartion of Home Manager and programs

:eyes: [home-manager/README](./home-manager/README.md).


#### Change default shell to `zsh`

Home Manager can't change the default shell, so we need to do it manually:

``` shell
# `which zsh`
which zsh
~/.nix-profile/bin/zsh

# add it to `/etc/shells`
sudo vi /etc/shells
 
# change shell to `zsh`
chsh -s ~/.nix-profile/bin/zsh
```
:eyes: How to make ZSH the default shell? https://askubuntu.com/a/1054798


#### Acknowledge

- NixOS Wiki: [Flakes](https://nixos.wiki/wiki/Flakes)
- Home Manager: [Documentation](https://nix-community.github.io/home-manager/)
- Zero to Flakes: [Using direnv to manage dev environments](https://zero-to-flakes.com/direnv)
- Johannes Schickling: [Setting up Nix on macOS from scratch (incl. dotfiles via home-manager and Nix flakes)](https://www.youtube.com/watch?v=1dzgVkgQ5mE)
- Vimjoyer: [Nix home-manager tutorial: Declare your entire home directory](https://www.youtube.com/watch?v=FcC2dzecovw&list=PLko9chwSoP-15ZtZxu64k_CuTzXrFpxPE&index=4)
- Alex Pearce: [Managing dotfiles with Nix](https://alexpearce.me/2021/07/managing-dotfiles-with-nix/)
- Red Tomato: [My Nix Journey - Use Nix on Ubuntu](https://tech.aufomm.com/my-nix-journey-use-nix-with-ubuntu/)
