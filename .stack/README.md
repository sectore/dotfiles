# Stack - personal configuration

## Installation

1. Install [Stack](https://docs.haskellstack.org/en/stable/README/#how-to-install)

2. Backup `config.yaml`
``` shell
mv ~/.stack/config.yaml ~/.stack/config.yaml__
```

3. Link all needed stuff located within `.stack` folder of this repo into `~/.stack`

``` shell
# link `config.yaml`
ln -s /{repo}/dotfiles/.stack/config.yaml ~/.stack/config.yaml
```
