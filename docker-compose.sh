#!/bin/bash

[ -e .env ] && . .env

COMPOSE_FILE=docker-compose.base.yml

[ "$ENABLE_MYSQL" = "false" ] || COMPOSE_FILE=${COMPOSE_FILE}:mysql/docker-compose.yml
[ "$ENABLE_PHP" = "false" ] || COMPOSE_FILE=${COMPOSE_FILE}:php/docker-compose.yml
[ "$ENABLE_NGINX" = "false" ] || COMPOSE_FILE=${COMPOSE_FILE}:nginx/docker-compose.yml

[ -f docker-compose.override.yml ] && COMPOSE_FILE=${COMPOSE_FILE}:docker-compose.override.yml

export COMPOSE_FILE=$COMPOSE_FILE

docker-compose "$*"
