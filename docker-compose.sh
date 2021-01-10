#!/bin/bash

[ -e .env ] && . .env

COMPOSE_FILE=docker-compose.base.yml

[ "$ENABLE_MYSQL" = "false" ] || COMPOSE_FILE=${COMPOSE_FILE}:mysql/docker-compose.yml
[ "$ENABLE_MONGO" = "false" ] || COMPOSE_FILE=${COMPOSE_FILE}:mongo/docker-compose.yml
[ "$ENABLE_PHP" = "false" ] || COMPOSE_FILE=${COMPOSE_FILE}:php-fpm/docker-compose.yml
[ "$ENABLE_NGINX" = "false" ] || COMPOSE_FILE=${COMPOSE_FILE}:nginx/docker-compose.yml
[ "$ENABLE_HTTPD" = "false" ] || COMPOSE_FILE=${COMPOSE_FILE}:httpd/docker-compose.yml
[ "$REDIS_PORT" = "false" ] || COMPOSE_FILE=${COMPOSE_FILE}:redis/docker-compose.yml

[ -f docker-compose.override.yml ] && COMPOSE_FILE=${COMPOSE_FILE}:docker-compose.override.yml

export COMPOSE_FILE=$COMPOSE_FILE

docker-compose $*
