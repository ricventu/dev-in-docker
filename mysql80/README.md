# DID MYSQL 8.0

## zshrc|bashrc

```
# .zshrc | .bashrc
function php() {
    docker run --rm --interactive --tty \
        --volume "$PWD":/app \
        did_php81 php $@
}
```

```bash
$ php --version
```

## example Laravel serve
```
docker run --rm --interactive --tty \
    --volume "$PWD":/app \
    -p "8000:8000" \
    did_php81 php artisan serve --host 0.0.0.0
```

## Composer

```
function composer() {
    docker run --rm --interactive --tty \
        --volume "$PWD":/app \
        did_php81 composer $@
}
```

```bash
$ composer create-project laravel/laravel my-app
```