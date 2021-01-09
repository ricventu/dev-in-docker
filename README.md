# dev-in-docker
Simple development environment with Docker

Clone this repo
```
git clone git@github.com:ricventu/dev-in-docker.git
```

## Command line

Add to `~.bashrc` or `.zshrc`:

```
function did() {
    ( cd path/to/dev-in-docker && ./docker-compose.sh $* )
}
```
where `path/to/dev-in-docker` is the path to dev-in-docker clone

then exec composer commands with `did`

```
did up -d --build
```

### Add php command line

Add to `~.bashrc` or `.zshrc`:
```
function didphp() {
    did run --rm -v $(pwd):/workdir/ -w /workdir/ php-fpm php $*
}
```

then exec php commands with `didphp`

```
didphp -v
```

### Add ssh shortcut to php ssh

Add to `~.bashrc` or `.zshrc`:
```
function didssh() {
    did exec php-fpm bash
}
```

then run `didssh`
