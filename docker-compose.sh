#!/usr/bin/env bash

[ -e .env ] && . .env

COMPOSE_FILE=docker-compose.base.yml

[ "$ENABLE_MYSQL" != "false" ] && COMPOSE_FILE=${COMPOSE_FILE}:mysql/docker-compose.yml
[ "$ENABLE_MONGO" != "false" ] && COMPOSE_FILE=${COMPOSE_FILE}:mongo/docker-compose.yml
[ "$ENABLE_NGINX" != "false" ] && COMPOSE_FILE=${COMPOSE_FILE}:nginx/docker-compose.yml
[ "$ENABLE_HTTPD" != "false" ] && COMPOSE_FILE=${COMPOSE_FILE}:httpd/docker-compose.yml
[ "$ENABLE_REDIS" != "false" ] && COMPOSE_FILE=${COMPOSE_FILE}:redis/docker-compose.yml
[ "$ENABLE_MAILHOG" != "false" ] && COMPOSE_FILE=${COMPOSE_FILE}:mailhog/docker-compose.yml

if [ ! "$ENABLE_PHP73" = "false" ]; then
  sed "s/__PHP_VERSION__/7.3/g" php/docker-compose-php.template.yml > php/docker-compose-php73.yml
  COMPOSE_FILE=${COMPOSE_FILE}:php/docker-compose-php73.yml
  cp php/docker-compose-nginx.template.yml php/docker-compose.nginx.yml
  echo "      - php7.3" >> php/docker-compose.nginx.yml
else
  [ -f php/docker-compose.nginx.yml ] && rm php/docker-compose.nginx.yml
fi

if [ "$ENABLE_PHP74" = "true" ]; then
  sed "s/__PHP_VERSION__/7.4/g" php/docker-compose-php.template.yml > php/docker-compose-php74.yml
  COMPOSE_FILE=${COMPOSE_FILE}:php/docker-compose-php74.yml
  cp php/docker-compose-nginx.template.yml php/docker-compose.nginx.yml
  echo "      - php7.4" >> php/docker-compose.nginx.yml
else
  [ -f php/docker-compose.nginx.yml ] && rm php/docker-compose.nginx.yml
fi

if [ ! "$ENABLE_NGINX" = "false" ]; then
  COMPOSE_FILE=${COMPOSE_FILE}:nginx/docker-compose.yml
  [ -f php/docker-compose.nginx.yml ] && COMPOSE_FILE=${COMPOSE_FILE}:php/docker-compose.nginx.yml
fi

[ -f docker-compose.override.yml ] && COMPOSE_FILE=${COMPOSE_FILE}:docker-compose.override.yml

export COMPOSE_FILE=$COMPOSE_FILE

[ "$EXPORT_CONF" = "false" ] || docker-compose config > docker-compose.yml

docker-compose $*
