#!/usr/bin/env bash

# defaults
COMPOSE_PROJECT_NAME=did
APP_CODE_PATH=./

[ -e .env ] && source .env

COMPOSE_FILE=docker-compose.base.yml

[ "$ENABLE_MYSQL" = "true" ] && COMPOSE_FILE=${COMPOSE_FILE}:mysql/docker-compose.yml
[ "$ENABLE_MARIADB" = "true" ] && COMPOSE_FILE=${COMPOSE_FILE}:mariadb/docker-compose.yml
[ "$ENABLE_MONGO" = "true" ] && COMPOSE_FILE=${COMPOSE_FILE}:mongo/docker-compose.yml
[ "$ENABLE_NGINX" = "true" ] && COMPOSE_FILE=${COMPOSE_FILE}:nginx/docker-compose.yml
[ "$ENABLE_HTTPD" = "true" ] && COMPOSE_FILE=${COMPOSE_FILE}:httpd/docker-compose.yml
[ "$ENABLE_REDIS" = "true" ] && COMPOSE_FILE=${COMPOSE_FILE}:redis/docker-compose.yml
[ "$ENABLE_MAILHOG" = "true" ] && COMPOSE_FILE=${COMPOSE_FILE}:mailhog/docker-compose.yml

[ -f php/docker-compose.nginx.yml ] && rm php/docker-compose.nginx.yml
[ -f php/docker-compose-php73.yml ] && rm php/docker-compose-php73.yml
[ -f php/docker-compose-php74.yml ] && rm php/docker-compose-php74.yml


if [ "$ENABLE_PHP73" = "true" ]; then
  sed "s/__PHP_VERSION__/7.3/g" php/docker-compose-php.template.yml > php/docker-compose-php73.yml
  COMPOSE_FILE=${COMPOSE_FILE}:php/docker-compose-php73.yml
  cp php/docker-compose-nginx.template.yml php/docker-compose.nginx.yml
  echo "      - php7.3" >> php/docker-compose.nginx.yml
fi

if [ "$ENABLE_PHP74" = "true" ]; then
  sed "s/__PHP_VERSION__/7.4/g" php/docker-compose-php.template.yml > php/docker-compose-php74.yml
  COMPOSE_FILE=${COMPOSE_FILE}:php/docker-compose-php74.yml
  cp php/docker-compose-nginx.template.yml php/docker-compose.nginx.yml
  echo "      - php7.4" >> php/docker-compose.nginx.yml
fi

if [ "$ENABLE_NGINX" = "true" ]; then
  COMPOSE_FILE=${COMPOSE_FILE}:nginx/docker-compose.yml
  [ -f php/docker-compose.nginx.yml ] && COMPOSE_FILE=${COMPOSE_FILE}:php/docker-compose.nginx.yml
fi

[ -f docker-compose.override.yml ] && COMPOSE_FILE=${COMPOSE_FILE}:docker-compose.override.yml

export COMPOSE_FILE=$COMPOSE_FILE
docker-compose config > docker-compose.yml

export COMPOSE_FILE=docker-compose.yml
docker-compose $*
