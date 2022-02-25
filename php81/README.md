# DID PHP 8.1

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
    -p "8000:8000"
    did_php81 php artisan serve
```
