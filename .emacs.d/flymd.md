# Prelude - personal configuration

## InstallationfLyMd-mAkEr

- Install [Prelude](https://github.com/bbatsov/prelude)

- Backup `personal` folder
``` shell
mv ~/.emacs.d/personal ~/.emacs.d/__personal
```

- Link files / folders from `.emacs` folder of this repo into `~/.emacs.d`

``` shell
# link prelude-modules
ln -s /{repo}/dotfiles/.emacs.d/prelude-modules.el ~/.emacs.d/prelude-modules.el
# link personal folder
ln -s /{repo}/dotfiles/.emacs.d/personal ~/.emacs.d/personal
```
