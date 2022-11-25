# Dev in docker

Ready to use dockerized tools

## Mailhog

To run [mailhog](https://github.com/mailhog/MailHog):
```sh
cd mailhog
make
```

## PHP 8.1

To create php image:
```sh
cd php81
make
```

To run `php` in terminal add this to your `.zshrc` or `.bashrc` config file:

```sh
# .zshrc or .bashrc
function php() {
    docker run --rm --interactive --tty \
            --volume "$PWD":/app \
            --user $(id -u):$(id -g) \
            did:php81 php $@
}
```
example:
```sh
$ php --version
```

### PHP Composer

to run `composer` in terminal add this to your `.zshrc` or `.bashrc` config file:

```sh
# .zshrc or .bashrc
function composer() {
    docker run --rm --interactive --tty \
            --volume "$PWD":/app \
            --user $(id -u):$(id -g) \
            did:php81 composer $@
}
```
example:
```sh
$ composer --version
```

### Laravel artisan serve

to run `artisan serve <port>`, add this to your `.zshrc` or `.bashrc` config file:

```sh
# .zshrc | .bashrc
function artisanserve() {
    PORT=$1
    [ -n $PORT ] || PORT=8000
    docker run --rm --interactive --tty \
            --volume "$PWD":/app \
            --user $(id -u):$(id -g) \
            -p "$PORT:8000" \
            did:php81 php artisan serve --host 0.0.0.0
}
```
example: run artisan serve on port 8080
```sh
$ artisanserve 8080
```

## Redis

To run Redis:
```sh
cd redis
make
```

## Portainer + Traefik

To run Portainer + Traefik:
```sh
cd portainer-traefik
make
```

