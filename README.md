# Dev In Docker
Simple development environment for Docker

# Install

## 1. Clone this repo
```
git clone git@github.com:ricventu/dev-in-docker.git
```

## 2. Add command line

Add to `~.bashrc` or `.zshrc`:

```
function did() {
    ( cd path/to/dev-in-docker && ./docker-compose.sh $* )
}
```
where `path/to/dev-in-docker` is the path to dev-in-docker clone

now you can exec all docker-composer commands with `did`

```
did up -d --build
```

## NGINX

Virtual hosts configurations are located in `nginx/sites`

## HTTPD

Virtual hosts configurations are located in `httpd/sites`

## PHP

You can add install `.sh` scripts to `php/install.d` directory 


## LOGS

Logs from containers are bind to `LOG_PATH` dir

## Shortcuts command

### Add php command line

Add to `~.bashrc` or `.zshrc`:
```
function didphp() {
    did run --rm -v $(pwd):/workdir/ -w /workdir/ php7.3 php $*
}
```

Now you can run php commands with `didphp`

```
didphp -v
```

### Add ssh shortcut to php ssh

Add to `~.bashrc` or `.zshrc`:
```
function didssh() {
    did exec php7.3 bash
}
```

Now you can connect to php container with `didssh`
