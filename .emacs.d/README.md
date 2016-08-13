# Prelude - personal configuration

## Installation

1. Install [Prelude](https://github.com/bbatsov/prelude)

2. Backup `personal` folder
``` shell
mv ~/.emacs.d/personal ~/.emacs.d/__personal
```

3. Link all needed stuff from `.emacs.d` folder of this repo into `~/.emacs.d`

``` shell
# link prelude-modules
ln -s /{repo}/dotfiles/.emacs.d/prelude-modules.el ~/.emacs.d/prelude-modules.el
# link personal folder
ln -s /{repo}/dotfiles/.emacs.d/personal ~/.emacs.d/personal
```
